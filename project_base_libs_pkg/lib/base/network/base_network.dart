enum NetworkMethod { get, post, put, upload }

/// 网络请求进度回调
typedef NetworkProgressCallback = void Function(int count, int total);

/// 网络请求的基类,抽象类
abstract class BaseNetwork {
  /// url地址
  String? url;

  /// 请求参数
  Map<String, dynamic>? parameters;

  /// 请求头
  Map<String, dynamic>? headers;

  /// 请求的数据(如上传的二进制文件,图片等)
  dynamic data;

  /// debug用信息
  dynamic debugInfo;

  /// 网络超时时间设置
  int requestTimeOut = 5000;

  /// 请求的方法
  NetworkMethod method = NetworkMethod.get;

  /// 网络请求上传数据时的进度 (只有post请求此参数才有效)
  NetworkProgressCallback? onSendProgress;

  /// 网络请求获取数据时的进度
  NetworkProgressCallback? onReceiveProgress;

  /// 网络请求配置
  BaseNetworkConfig config = const BaseNetworkConfig();

  /// 请求返回数据的处理
  BaseNetworkResultTransform resultDataTransform = const BaseNetworkResultTransform();

  /// 请求开始后的回调信息
  BaseRequestCallback requestCallback = const BaseRequestCallback();

  /* abstract方法 */

  /// (abstract) 获取网络请求的future对象
  Future<dynamic> startRequest();

  /// (abstract) 网络请求开始
  void start<T, E>({Function(T, BaseNetwork)? onSuccess, Function(E, BaseNetwork)? onError});

  /// (abstract) 是否正在运行中
  bool get isRunning;

  /// (abstract) 网络请求关闭(根据子类实现,有可能是强制关闭)
  void close();

  /// (abstract) 网络请求取消
  void cancel();

  /* setter方法 */

  BaseNetwork setUrl(String? newVal) {
    url = newVal;
    return this;
  }

  BaseNetwork setParameters(Map<String, dynamic>? newVal) {
    parameters = newVal;
    return this;
  }

  BaseNetwork setHeaders(Map<String, dynamic>? newVal) {
    headers = newVal;
    return this;
  }

  BaseNetwork setData(dynamic newVal) {
    data = newVal;
    return this;
  }

  BaseNetwork setRequestTimeOut(int newVal) {
    requestTimeOut = newVal;
    return this;
  }

  BaseNetwork setMethod(NetworkMethod newVal) {
    method = newVal;
    return this;
  }

  BaseNetwork setOnSendProgress(NetworkProgressCallback callback) {
    onSendProgress = callback;
    return this;
  }

  BaseNetwork setOnReceiveProgress(NetworkProgressCallback callback) {
    onReceiveProgress = callback;
    return this;
  }

  BaseNetwork setConfig(BaseNetworkConfig newVal) {
    config = newVal;
    return this;
  }

  BaseNetwork setResultTransform(BaseNetworkResultTransform newVal) {
    resultDataTransform = newVal;
    return this;
  }
}

/// 网络请求的回调信息,包含请求开始时的回调以及请求结束的回调
class BaseRequestCallback {
  const BaseRequestCallback();

  /// 开始请求的回调
  void startRequestCallback(BaseNetwork network) {}

  /// 结束请求的回调
  void endRequestCallback(BaseNetwork network) {}
}

/// 网络请求数据转换的工具,默认实现为空实现,子类根据需要重写功能
class BaseNetworkResultTransform {
  const BaseNetworkResultTransform();

  /// 返回成功数据的转化处理
  Future<dynamic> successDataTransform(dynamic data, BaseNetwork network) => Future.value(data);

  /// 返回失败数据的转化处理
  Future<dynamic> errorDataTransform(dynamic data, BaseNetwork network) => Future.error(data);
}

/// 网络请求的配置类,子类根据需要重写功能
class BaseNetworkConfig {
  const BaseNetworkConfig();

  /// 开始进行配置
  void startConfig(dynamic object) {}

  /// 获取配置的值
  dynamic configValue(dynamic object) {}
}
