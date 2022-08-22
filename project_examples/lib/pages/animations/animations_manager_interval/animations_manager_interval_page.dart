import 'package:flutter/material.dart';
import 'package:project_examples/pages/base/normal_stateful_widget.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class AnimationsManagerIntervalPage extends NormalStatefulWidget {
  const AnimationsManagerIntervalPage({Key? key}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AnimationsManagerIntervalPageState();
}

class AnimationsManagerIntervalPageState extends NormalStatefulWidgetState<AnimationsManagerIntervalPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
      );

  @override
  Widget body(BuildContext context) => const AnimationsManagerUseDemo();
}

class AnimationsManagerUseDemo extends StatefulWidget {
  const AnimationsManagerUseDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimationsManagerUseDemoState();
}

class _AnimationsManagerUseDemoState extends State<AnimationsManagerUseDemo> with SingleTickerProviderStateMixin {
  static const String textBgColor = 'bgColor';
  static const String containerHeight = 'containerHeight';
  late AnimationsManager manager;

  @override
  void initState() {
    super.initState();

    manager = AnimationsManager(
      tickerProvider: this,
      duration: const Duration(seconds: 1),
      animationObjectMap: {
        textBgColor: CurveTweenObject(tween: IntTween(begin: 0, end: 255), curve: Curves.linear.withInterval(0, 0.5)),
        containerHeight: CurveTweenObject(tween: Tween<double>(begin: 40, end: 200), curve: Curves.easeOutQuint.withInterval(0.5, 1)),
      },
      completedCallback: () => manager.reverse(),
      dismissedCallback: () => manager.forward(),
    );

    manager.forward();
  }

  @override
  void dispose() {
    manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return manager.animatedBuilder(
      child: const Text('AnimationsManager与Interval配合使用'),
      builder: (context, child) {
        return Container(
          color: Color.fromARGB(manager.animationByKey(textBgColor).value, 255, 1, 1),
          height: manager.animationByKey(containerHeight).value,
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}