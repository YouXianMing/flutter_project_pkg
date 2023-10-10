import 'package:flutter/material.dart';

class AnimatedOpacityRepeat extends StatefulWidget {
  /// 子控件
  final Widget child;

  /// 动画时间
  final Duration duration;

  /// 曲线,默认值为 Curves.easeInOut
  final Curve curve;

  /// Tween,如果为空,默认为 Tween(begin: 0.3, end: 1)
  final Tween<double>? tween;

  const AnimatedOpacityRepeat({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeInOut,
    this.tween,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimatedOpacityRepeatState();
}

class AnimatedOpacityRepeatState extends State<AnimatedOpacityRepeat> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<double> _tween;

  @override
  void initState() {
    super.initState();

    double begin = widget.tween?.begin ?? 0.3;
    double end = widget.tween?.end ?? 1;
    if (begin < 0) begin = 0;
    if (end > 1) end = 1;

    _tween = Tween<double>(begin: begin, end: end);
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _tween.animate(CurvedAnimation(parent: _controller, curve: widget.curve)),
      child: widget.child,
    );
  }
}
