import 'package:project_examples/file_headers.dart';

class GroupAnimationPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const GroupAnimationPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => GroupAnimationPageState();
}

class GroupAnimationPageState extends NormalStatefulWidgetState<GroupAnimationPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) => _GroupAnimationDemo();
}

class _GroupAnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroupAnimationDemoState();
}

class _GroupAnimationDemoState extends State<_GroupAnimationDemo> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorAnimation;
  late Animation _sizeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _animationController.addListener(() {
      setState(() {});
    });

    /// 动画总时间5秒
    /// Interval(0.0, 0.80) 表示从0秒到4秒(总时间的4/5,通过百分比计算得出)
    /// Interval(0.80, 1.0) 表示从4秒到5秒(总时间的1/5,通过百分比计算得出)

    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.blue)
        .animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.0, 0.80)));

    _sizeAnimation = Tween(begin: 100.0, end: 300.0)
        .animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.80, 1.0, curve: Curves.bounceOut)));

    //开始动画
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: _sizeAnimation.value,
            width: _sizeAnimation.value,
            color: _colorAnimation.value,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
