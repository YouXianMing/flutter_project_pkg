import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/base_stateful_widget.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';

class TweenSequenceAnimationPage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const TweenSequenceAnimationPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => TweenSequenceAnimationPageState();
}

class TweenSequenceAnimationPageState extends NormalStatefulWidgetState<TweenSequenceAnimationPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
    context: context,
    title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
  );

  @override
  Widget body(BuildContext context) => _TweenSequenceAnimationDemo();
}

class _TweenSequenceAnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TweenSequenceAnimationDemoState();
}

class _TweenSequenceAnimationDemoState extends State<_TweenSequenceAnimationDemo> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _animationController.addListener(() {
      setState(() {});
    });

    /// weight是权重,40+20+40=100,第一段动画时间是5x0.4=2s,第二段动画是5x0.2=1s,第三段动画是5x0.4=2s
    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 100.0, end: 200.0).chain(CurveTween(curve: Curves.easeIn)), weight: 40),
      TweenSequenceItem(tween: ConstantTween<double>(200.0), weight: 20), // 常量值动画
      TweenSequenceItem(tween: Tween(begin: 200.0, end: 300.0), weight: 40),
    ]).animate(_animationController);

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
          Container(height: _animation.value, width: _animation.value, color: Colors.red),
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
