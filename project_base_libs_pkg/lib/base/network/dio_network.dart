import 'package:dio/dio.dart' as dio;
import 'base_network.dart';

/// 用dio的网络库实现了BaseNetwork中的所有抽象方法,符合里氏替换原则
class DioNetwork extends BaseNetwork {
  /// dio的实体
  late dio.Dio _dio;

  /// 当前网络是否正在运行
  bool _isRunning = false;

  /// 取消请求的token(如何使用cancelToken https://stackguides.com/questions/68581009/dio-canceltoken)
  dio.CancelToken? _cancelToken;

  DioNetwork({
    String? url,
    Map<String, dynamic>? parameters,
    dynamic data,
    Map<String, dynamic>? headers,
    int requestTimeOut = 10000,
    NetworkMethod method = NetworkMethod.get,
    NetworkProgressCallback? onReceiveProgress,
    NetworkProgressCallback? onSendProgress,
    BaseNetworkConfig? config,
    BaseNetworkResultTransform? resultDataTransform,
    BaseRequestCallback? requestCallback,
  }) {
    this.url = url;
    this.parameters = parameters;
    this.data = data;
    this.headers = headers;
    this.requestTimeOut = requestTimeOut;
    this.method = method;
    this.onReceiveProgress = onReceiveProgress;
    this.onSendProgress = onSendProgress;

    // 如果配置为空,则默认使用DioNetworkConfig
    this.config = config ?? DioNetworkConfig();

    if (resultDataTransform != null) this.resultDataTransform = resultDataTransform;
    if (requestCallback != null) this.requestCallback = requestCallback;
  }

  /// 此处的网络请求close会导致请求关闭并报错
  @override
  void close({bool force = false}) => _dio.close(force: force);

  @override
  void cancel() {
    if (_cancelToken != null) {
      // 调用取消的话,会在catch (e) 的e中,使用 if (e is DioError && e.error is String && e.error == 'cancelled') 来判断
      // 网络请求的取消
      _cancelToken?.cancel('cancelled');
    }
  }

  @override
  Future<dynamic> startRequest() async {
    _dio = dio.Dio();
    _cancelToken = dio.CancelToken();
    // 设置当前正在执行网络请求
    _isRunning = true;
    requestStartTime = DateTime.now();
    try {
      // 请求开始之前进行一些配置
      dynamic object = {'obj': this, 'dio': _dio};
      config.startConfig(object);

      if (method == NetworkMethod.get) {
        // 请求开始前回调
        requestCallback.startRequestCallback(this);

        // 开始请求
        dio.Response result = await _dio.get(
          url!,
          options: config.configValue(object),
          queryParameters: parameters,
          cancelToken: _cancelToken,
          onReceiveProgress: onReceiveProgress,
        );

        // 清空cancelToken
        _cancelToken = null;

        // 请求结束回调
        requestCallback.endRequestCallback(this);

        // 设置网路请求结束了
        _isRunning = false;
        requestFinishedTime = DateTime.now();

        // 此处的result被dio的Response包裹着,注意
        return resultDataTransform.successDataTransform(result, this);
      } else if (method == NetworkMethod.post ||
          method == NetworkMethod.upload ||
          method == NetworkMethod.put ||
          method == NetworkMethod.delete) {
        // 请求开始前回调
        requestCallback.startRequestCallback(this);

        // 开始请求
        late dio.Response result;

        if (method == NetworkMethod.post || method == NetworkMethod.upload) {
          result = await _dio.post(
            url!,
            options: config.configValue(object),
            data: data,
            queryParameters: parameters,
            cancelToken: _cancelToken,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
        } else if (method == NetworkMethod.put) {
          result = await _dio.put(
            url!,
            options: config.configValue(object),
            data: data,
            queryParameters: parameters,
            cancelToken: _cancelToken,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
        } else if (method == NetworkMethod.delete) {
          result = await _dio.delete(
            url!,
            options: config.configValue(object),
            data: data,
            queryParameters: parameters,
            cancelToken: _cancelToken,
          );
        }

        // 清空cancelToken
        _cancelToken = null;

        // 请求结束回调
        requestCallback.endRequestCallback(this);

        // 设置网路请求结束了
        _isRunning = false;
        requestFinishedTime = DateTime.now();

        // 此处的result被dio的Response包裹着,注意
        return resultDataTransform.successDataTransform(result, this);
      }
    } catch (e) {
      // 请求结束回调
      requestCallback.endRequestCallback(this);

      // 设置网路请求结束了
      _isRunning = false;
      requestFinishedTime = DateTime.now();

      // 此处的result是一个失败的网络请求
      return resultDataTransform.errorDataTransform(e, this);
    }
  }

  @override
  void start<T, E>({Function(T, BaseNetwork)? onSuccess, Function(E, BaseNetwork)? onError}) {
    startRequest().then((value) {
      if (onSuccess != null) onSuccess(value, this);
    }, onError: (e) {
      if (onError != null) onError(e, this);
    });
  }

  @override
  bool get isRunning => _isRunning;
}

/// 针对dio网络库的默认配置文件,可以通过继承BaseNetworkConfig来实现新的配置文件
class DioNetworkConfig extends BaseNetworkConfig {
  /// 请求头部的content-type字段
  final String contentType;

  /// 设置返回数据的格式
  final dio.ResponseType responseType;

  /// 获取数据时的超时时间(此时已和服务器建立链接,等待服务器发送数据的间隔时间,如果为0,则表示不会超时,一直等待服务器的回应)
  final int receiveTimeout;

  /// 发送数据时的超时时间(此时已经向网络发送了数据,等待网络回应的时间)
  final int sendTimeout;

  DioNetworkConfig({
    this.contentType = 'application/x-www-form-urlencoded; charset=UTF-8',
    this.responseType = dio.ResponseType.json,
    this.receiveTimeout = 20000,
    this.sendTimeout = 20000,
  });

  @override
  void startConfig(object) {
    DioNetwork network = object['obj'];
    dio.Dio dioObj = object['dio'];
    dioObj.options.receiveTimeout = receiveTimeout;
    dioObj.options.sendTimeout = sendTimeout;
    dioObj.options.connectTimeout = network.requestTimeOut;
  }

  @override
  dynamic configValue(object) {
    DioNetwork network = object['obj'];
    return dio.Options(headers: network.headers, contentType: contentType, responseType: responseType);
  }
}
