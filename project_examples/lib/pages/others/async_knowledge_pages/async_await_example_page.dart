import 'package:flutter/material.dart';
import 'package:project_examples/pages/base/normal_stateless_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class AsyncAwaitExamplePage extends NormalStatelessWidget {
  final RxString info = ''.obs;
  AsyncAwaitExamplePage({Key? key}) : super(key: key);
  void updateInfo(text) => info.value = text;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(context: context, title: NormalAppBar.titleWidget(Get.arguments));

  Future<String> futureEvent() => Future.delayed(const Duration(seconds: 2), () => '数据');

  /// 对Future对象使用await会导致阻塞,且方法需要标记为async,直接调用该方法不会导致阻塞
  Future<void> start() async {
    updateInfo('阻塞中...');
    var result = await futureEvent();
    updateInfo('结果: $result');
  }

  @override
  Widget body(BuildContext context) {
    start();
    return Center(child: Obx(() => Text(info.value)));
  }
}
