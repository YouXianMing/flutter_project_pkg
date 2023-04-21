import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_base_libs_pkg/third_lib_dio.dart' as dio;
import 'package:project_examples/widgets/app_button.dart';
import 'package:project_examples/file_headers.dart';

class NetworksPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const NetworksPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => NetworksPageState();
}

enum GetPictureState {
  idle,
  start,
  cancel,
  success,
  error,
}

class NetworksPageState extends NormalStatefulWidgetState<NetworksPage> {
  DioNetwork? weatherNetwork;
  DioNetwork? pictureNetwork;
  final pictureState = GetPictureState.idle.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverListSection.staticTypeWidget(
          children: [
            AppButton(
              style: AppButtonStyle.blue,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 10),
              onTap: () {
                // 普通的get请求,使用的都是默认的配置
                weatherNetwork ??= DioNetwork(url: 'http://www.weather.com.cn/data/sk/101010100.html');

                // 使用isRunning可以防止网络请求重复创建
                if (weatherNetwork!.isRunning == false) {
                  innerLoading.show();
                  weatherNetwork?.startRequest().then((value) {
                    innerLoading.hide();
                    showMessage(context, value.toString(), success: true);
                  }, onError: (e) {
                    innerLoading.hide();
                    showMessage(context, e.toString(), success: false);
                  });
                }
              },
              child: WidgetsFactory.text('请求天气数据 (GET)', color: Colors.white),
            ),
            AppButton(
              style: AppButtonStyle.blue,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 10),
              onTap: () {
                // 高清大图
                String url =
                    'https://desk-fd.zol-img.com.cn/t_s4096x2160c5/g6/M00/0C/01/ChMkKmHnsAqIFt8vABqTH0iFN-EAAXvNgENmLQAGpM3114.jpg';

                pictureNetwork ??= DioNetwork(url: url);
                if (pictureNetwork!.isRunning == false) {
                  pictureState.value = GetPictureState.start;
                  pictureNetwork
                      ?.setResultTransform(DownloadNetworkResultDataTransform())
                      .setConfig(DownloadNetworkConfig())
                      .setOnReceiveProgress((count, total) {
                        appPrint('进度: ${(count / total).toDouble()}');
                      })
                      .startRequest()
                      .then((value) {
                        pictureState.value = GetPictureState.success;
                        appPrint(value.runtimeType);
                        showMessage(context, '成功', success: true, didHide: () => pictureState.value = GetPictureState.idle);
                      }, onError: (e) {
                        if (e is dio.DioError && e.error is String && e.error == 'cancelled') {
                          showMessage(context, '网络请求取消了', success: false, didHide: () => pictureState.value = GetPictureState.idle);
                        } else {
                          pictureState.value = GetPictureState.error;
                          showMessage(context, e.toString(), success: false, didHide: () => pictureState.value = GetPictureState.idle);
                        }
                      });
                }
              },
              child: Obx(() {
                switch (pictureState.value) {
                  case GetPictureState.idle:
                    return WidgetsFactory.text('获取二进制文件 (GET)', color: Colors.white);
                  case GetPictureState.start:
                    return WidgetsFactory.text('请求中...', color: Colors.white);
                  case GetPictureState.success:
                    return WidgetsFactory.text('请求成功', color: Colors.white);
                  case GetPictureState.error:
                    return WidgetsFactory.text('请求失败', color: Colors.white);
                  case GetPictureState.cancel:
                    return WidgetsFactory.text('取消了', color: Colors.white);
                }
              }),
            ),
            Obx(() {
              late bool disable;
              switch (pictureState.value) {
                case GetPictureState.cancel:
                case GetPictureState.success:
                case GetPictureState.error:
                case GetPictureState.idle:
                  disable = true;
                  break;
                case GetPictureState.start:
                  disable = false;
                  break;
              }

              return AppButton(
                disable: disable,
                style: AppButtonStyle.red,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 10),
                onTap: () {
                  pictureState.value = GetPictureState.cancel;
                  pictureNetwork?.cancel();
                },
                child: WidgetsFactory.text('取消 获取二进制文件 (GET)', color: Colors.white),
              );
            }),
          ],
        ),
      ],
    );
  }
}

class DownloadNetworkResultDataTransform extends BaseNetworkResultTransform {
  @override
  Future successDataTransform(dynamic data, BaseNetwork network) {
    // 对dio的response数据进行加工,此处直接返回二进制文件,没有进行加工
    dio.Response response = data;
    return Future.value(response.data);
  }
}

class DownloadNetworkConfig extends BaseNetworkConfig {
  final String contentType;
  final dio.ResponseType responseType;
  final int receiveTimeout;
  final int sendTimeout;

  DownloadNetworkConfig({
    this.contentType = 'application/octet-stream',
    this.responseType = dio.ResponseType.bytes,
    this.receiveTimeout = 60000,
    this.sendTimeout = 10000,
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
