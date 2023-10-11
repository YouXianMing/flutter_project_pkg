import 'package:flutter/material.dart';

class AnimatedSlideRepeat extends StatefulWidget {
  /// 子控件
  final Widget child;

  /// 动画时间
  final Duration duration;

  /// 曲线,默认值为 Curves.easeInOut
  final Curve curve;

  /// Tween,如果为空,默认为 Tween(begin: const Offset(-0.5, 0), end: const Offset(0.5, 0))
  /// dx=0.5表示移动当前组件0.5倍的宽度,dy=0.5表示移动当前组件0.5倍的高度
  final Tween<Offset>? tween;

  const AnimatedSlideRepeat({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeInOut,
    this.tween,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimatedSlideRepeatState();
}

class AnimatedSlideRepeatState extends State<AnimatedSlideRepeat> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<Offset> _tween;

  @override
  void initState() {
    super.initState();

    Offset begin = widget.tween?.begin ?? const Offset(-0.5, 0);
    Offset end = widget.tween?.end ?? const Offset(0.5, 0);

    _tween = Tween<Offset>(begin: begin, end: end);
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
    return SlideTransition(
      position: _tween.animate(CurvedAnimation(parent: _controller, curve: widget.curve)),
      child: widget.child,
    );
  }
}
