import 'package:project_base_libs_pkg/base/managers/animations_manager.dart';
import 'package:project_examples/file_headers.dart';

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
  static const String _textBgColor = 'bgColor';
  static const String _containerHeight = 'containerHeight';
  late AnimationsManager _manager;

  @override
  void initState() {
    super.initState();

    _manager = AnimationsManager(
      tickerProvider: this,
      duration: const Duration(seconds: 1),
      animationObjectMap: {
        _textBgColor: CurveTweenObject(tween: IntTween(begin: 0, end: 255)),
        _containerHeight: CurveTweenObject(tween: Tween<double>(begin: 40, end: 200), curve: Curves.easeOutQuint),
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
      child: const Text('AnimationsManager的使用'),
      builder: (context, child) {
        return Container(
          color: Color.fromARGB(_manager.animationByKey(_textBgColor).value, 255, 1, 1),
          height: _manager.animationByKey(_containerHeight).value,
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
