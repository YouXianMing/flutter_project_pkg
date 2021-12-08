import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class GetxRefreshPage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const GetxRefreshPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => GetxRefreshPageState();
}

class GetxRefreshPageState extends NormalStatefulWidgetState<GetxRefreshPage> {
  final RxInt step = 0.obs;
  final GetCounterLogic logic = GetCounterLogic();

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(context: context, title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''));

  @override
  Widget body(BuildContext context) {
    // https://stackoverflow.com/questions/67121941/flutter-get-when-to-use-getxcontroller-getbuildercontroller-or-obx

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Obx
          Obx(
            () => Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: WidgetsFactory.text(step.value.toString(), fontSize: 30, color: Util.randomOpaqueColor),
              ),
            ),
          ),
          TextButton(onPressed: () => step.value++, child: const Text('更新Obx')),
          // GetBuilder
          GetBuilder<GetCounterLogic>(
            init: logic, // 传入GetxController
            global: true, // 如果global为true,则添加到GetInstance()中,销毁时会触发onClose方法,默认为true
            builder: (b) => Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: WidgetsFactory.text(b.count.toString(), fontSize: 30, color: Util.randomOpaqueColor),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                // 更新数据
                logic.count++;
                // 手动更新UI
                logic.update();
              },
              child: const Text('更新GetBuilder')),
          const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
          TextButton(onPressed: () => setState(() {}), child: const Text('setState()')),
        ],
      ),
    );
  }
}

class GetCounterLogic extends GetxController {
  var count = 0;

  @override
  void onClose() {
    super.onClose();
    appPrint('onClose');
  }

  @override
  void onInit() {
    super.onInit();
    appPrint('onInit');
  }

  @override
  void onReady() {
    super.onReady();
    appPrint('onReady');
  }
}
