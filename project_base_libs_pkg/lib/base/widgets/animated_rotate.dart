import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedRotate extends StatefulWidget {
  /// 子控件
  final Widget child;

  /// 旋转一周需要的时间,默认为2000毫秒
  final Duration duration;

  /// 是否是顺时针,默认为true
  final bool clockwise;

  /// 暂停
  final bool pause;

  const AnimatedRotate({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 2000),
    this.clockwise = true,
    this.pause = false,
  }) : super(key: key);

  @override
  _AnimatedRotateState createState() => _AnimatedRotateState();
}

class _AnimatedRotateState extends State<AnimatedRotate> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
    if (widget.pause) {
      _controller.stop();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedRotate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pause == true) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, builderChild) => Transform.rotate(
        angle: widget.clockwise ? _controller.value * 2 * pi : -_controller.value * 2 * pi,
        child: builderChild,
      ),
      child: widget.child,
    );
  }
}
