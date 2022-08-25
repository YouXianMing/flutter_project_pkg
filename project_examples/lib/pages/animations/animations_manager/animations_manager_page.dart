import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/base_stateful_widget.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/base/managers/animations_manager.dart';
import 'package:project_examples/app_route_style.dart';

class AnimationsManagerPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const AnimationsManagerPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AnimationsManagerPageState();
}

class AnimationsManagerPageState extends NormalStatefulWidgetState<AnimationsManagerPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
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
        textBgColor: CurveTweenObject(tween: IntTween(begin: 0, end: 255)),
        containerHeight: CurveTweenObject(tween: Tween<double>(begin: 40, end: 200), curve: Curves.easeOutQuint),
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
      child: const Text('AnimationsManager的使用'),
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
