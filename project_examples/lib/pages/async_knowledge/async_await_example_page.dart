import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/base_stateful_widget.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class AsyncAwaitExamplePage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const AsyncAwaitExamplePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AsyncAwaitExamplePageState();
}

class AsyncAwaitExamplePageState extends NormalStatefulWidgetState<AsyncAwaitExamplePage> {
  final info = ''.obs;

  void updateInfo(text) => info.value = text;

  Future<String> futureEvent() => Future.delayed(const Duration(seconds: 2), () => '数据');

  /// 对Future对象使用await会导致阻塞,且方法需要标记为async,直接调用该方法不会导致阻塞
  Future<void> start() async {
    updateInfo('阻塞中...');
    var result = await futureEvent();
    updateInfo('结果: $result');
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(context: context, title: NormalAppBar.titleWidget(Get.arguments));

  @override
  Widget body(BuildContext context) => Center(child: Obx(() => Text(info.value)));
}
