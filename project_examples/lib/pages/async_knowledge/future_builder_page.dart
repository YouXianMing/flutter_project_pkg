import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/base_stateful_widget.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_examples/app_route_style.dart';

class FutureBuilderPage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const FutureBuilderPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => FutureBuilderPageState();
}

class FutureBuilderPageState extends NormalStatefulWidgetState<FutureBuilderPage> {
  final RxBool start = false.obs;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Obx(() => FutureBuilder(
          future: start.value == true ? Future<String>.delayed(const Duration(seconds: 3), () => '结束') : null,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return GestureDetector(
                  onTap: () {
                    start.value = true;
                    innerLoading.show();
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    color: Colors.black,
                    child: const Text('开始', style: TextStyle(color: Colors.white)),
                  ),
                );

              case ConnectionState.waiting:
                return Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  color: Colors.green,
                  child: const Text('运行中', style: TextStyle(color: Colors.white)),
                );

              case ConnectionState.done:
                innerLoading.hide(afterDelay: const Duration(milliseconds: 20));
                return Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  color: Colors.red,
                  child: Text(snapshot.data, style: const TextStyle(color: Colors.white)),
                );

              default:
                return const SizedBox();
            }
          },
        ));
  }
}
