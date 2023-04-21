import 'package:project_examples/file_headers.dart';

class BaseAnimatedPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const BaseAnimatedPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => BaseAnimatedPageState();
}

class BaseAnimatedPageState extends NormalStatefulWidgetState<BaseAnimatedPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) => _BaseAnimatedUseDemo();
}

class _BaseAnimatedUseDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaseAnimatedUseDemoState();
}

class _BaseAnimatedUseDemoState extends State<_BaseAnimatedUseDemo> with SingleTickerProviderStateMixin {
  /// 控制器
  late AnimationController _controller;

  late Animation<int> _bgColorAnimation;
  late Animation<int> _textColorAnimation;

  @override
  void initState() {
    super.initState();

    /// 动画控制器
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);

    /// 背景色动画(曲线动画)
    {
      /// 曲线
      Curve curve = Curves.easeIn;

      /// 给动画增加曲线
      CurvedAnimation curvedAnimation = CurvedAnimation(parent: _controller, curve: curve);

      /// 动画
      _bgColorAnimation = IntTween(begin: 0, end: 255).animate(curvedAnimation);
    }

    /// 文本颜色动画(线性动画)
    {
      _textColorAnimation = IntTween(begin: 255, end: 0).animate(_controller);
    }

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      /// 监听动画状态的变化
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      } else if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20 + _controller.value * 20),
        color: Color.fromARGB(_bgColorAnimation.value, 255, 1, 1),
        child: Text('文本', style: TextStyle(color: Color.fromARGB(_textColorAnimation.value, 1, 1, 1))),
      ),
    );
  }
}
