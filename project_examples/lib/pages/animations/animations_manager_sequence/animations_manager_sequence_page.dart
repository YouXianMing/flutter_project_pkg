import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class AnimationsManagerSequencePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const AnimationsManagerSequencePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AnimationsManagerSequencePageState();
}

class AnimationsManagerSequencePageState extends NormalStatefulWidgetState<AnimationsManagerSequencePage> {
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
  static const String _offsetY = 'offsetY';
  late AnimationsManager _manager;

  @override
  void initState() {
    super.initState();

    _manager = AnimationsManager(
      tickerProvider: this,
      duration: const Duration(seconds: 3),
      animationObjectMap: {
        _offsetY: TweenSequenceObject(items: [
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 100.0).chain(CurveTween(curve: Curves.easeIn)), weight: 40),
          TweenSequenceItem(tween: ConstantTween<double>(100.0), weight: 40), // 常量值动画
          TweenSequenceItem(tween: Tween(begin: 100.0, end: 200.0).chain(CurveTween(curve: Curves.easeIn)), weight: 40),
        ]),
      },
      completedCallback: () => _manager.reverse(),
      dismissedCallback: () => _manager.forward(),
    );

    _manager.forward();
  }

  @override
  void dispose() {
    _manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _manager.animatedBuilder(
      child: const Text('AnimationsManager与Sequence配合使用'),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _manager.animationByKey(_offsetY).value),
          child: Container(
            color: Colors.red.withOpacity(0.2),
            height: 40,
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
    );
  }
}
