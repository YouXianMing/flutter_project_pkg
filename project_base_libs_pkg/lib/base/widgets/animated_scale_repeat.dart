import 'package:flutter/material.dart';

class AnimatedScaleRepeat extends StatefulWidget {
  /// 子空间
  final Widget child;

  /// 动画时间
  final Duration duration;

  /// 曲线,默认值为 Curves.elasticOut
  final Curve curve;

  /// Tween,如果为空,默认为 Tween(begin: 0.75, end: 1)
  final Tween<double>? tween;

  const AnimatedScaleRepeat({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.elasticOut,
    this.tween,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimatedScaleRepeatState();
}

class AnimatedScaleRepeatState extends State<AnimatedScaleRepeat> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<double> _tween;

  @override
  void initState() {
    super.initState();

    _tween = (widget.tween != null ? widget.tween! : Tween(begin: 0.75, end: 1));
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
    return ScaleTransition(
      scale: _tween.animate(CurvedAnimation(parent: _controller, curve: widget.curve)),
      child: widget.child,
    );
  }
}
