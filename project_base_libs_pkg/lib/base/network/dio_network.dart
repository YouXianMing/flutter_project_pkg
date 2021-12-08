import 'package:dio/dio.dart' as dio;
import 'base_network.dart';

class DioNetwork extends BaseNetwork {
  late dio.Dio _dio;
  bool _isRunning = false;

  DioNetwork({
    String? url,
    Map<String, dynamic>? parameters,
    dynamic data,
    Map<String, dynamic>? headers,
    int requestTimeOut = 5000,
    NetworkMethod method = NetworkMethod.get,
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

    // 如果配置为空,则默认使用DioNetworkConfig
    if (config != null) {
      this.config = config;
    } else {
      this.config = DioNetworkConfig();
    }

    if (resultDataTransform != null) this.resultDataTransform = resultDataTransform;
    if (requestCallback != null) this.requestCallback = requestCallback;
  }

  @override
  void close({bool force = false}) => _dio.close(force: false);

  @override
  Future<dynamic> startRequest() async {
    _dio = dio.Dio();
    _isRunning = true;
    try {
      /// 请求开始之前进行一些配置
      dynamic object = {'obj': this, 'dio': _dio};
      config.startConfig(object);
      if (method == NetworkMethod.get) {
        requestCallback.startRequestCallback(this);
        dio.Response result = await _dio.get(url!, options: config.configValue(object), queryParameters: parameters);
        requestCallback.endRequestCallback(this);
        _isRunning = false;
        // 此处的result被dio的Response包裹着,注意
        return resultDataTransform.successDataTransform(result, this);
      } else if (method == NetworkMethod.post) {
        requestCallback.startRequestCallback(this);
        dio.Response result = await _dio.post(url!, options: config.configValue(object), data: data, queryParameters: parameters);
        requestCallback.endRequestCallback(this);
        _isRunning = false;
        // 此处的result被dio的Response包裹着,注意
        return resultDataTransform.successDataTransform(result, this);
      }
    } catch (e) {
      requestCallback.endRequestCallback(this);
      _isRunning = false;
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

class DioNetworkConfig extends BaseNetworkConfig {
  final String contentType;
  final dio.ResponseType responseType;
  final int receiveTimeout;
  final int sendTimeout;

  DioNetworkConfig({
    this.contentType = 'application/x-www-form-urlencoded; charset=UTF-8',
    this.responseType = dio.ResponseType.json,
    this.receiveTimeout = 6000,
    this.sendTimeout = 60000,
  });

  @override
  void startConfig(object) {
    DioNetwork network = object['obj'];
    dio.Dio dioObj = object['dio'];
    dioObj.options.receiveTimeout = receiveTimeout;
    dioObj.options.connectTimeout = network.requestTimeOut;
    dioObj.options.sendTimeout = sendTimeout;
  }

  @override
  dynamic configValue(object) {
    DioNetwork network = object['obj'];
    return dio.Options(headers: network.headers, contentType: contentType, responseType: responseType);
  }
}
