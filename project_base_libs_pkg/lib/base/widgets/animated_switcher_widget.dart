import 'package:flutter/material.dart';

/// 对AnimatedSwitcher进行封装,简化使用
class AnimatedSwitcherWidget extends StatelessWidget {
  /// 动画时间,默认为200毫秒
  final Duration duration;

  /// 反转动画时间
  final Duration? reverseDuration;

  /// 直接设置valueKey.如果有值,则优先使用valueKey,data作为key则会失效
  final ValueKey? valueKey;

  /// 数据源
  final dynamic data;

  /// 是否将数据源data当做Builder组件的key使用,默认为true,只对data有效
  final bool useDataAsValueKey;

  /// widget构造器
  final Widget Function(BuildContext context, dynamic data) builder;

  /// transition builder
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

  /// layout builder
  final AnimatedSwitcherLayoutBuilder layoutBuilder;

  /// switch in curve
  final Curve switchInCurve;

  /// switch out curve
  final Curve switchOutCurve;

  const AnimatedSwitcherWidget({
    Key? key,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration,
    this.data,
    this.useDataAsValueKey = true,
    this.valueKey,
    required this.builder,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder,
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: reverseDuration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: transitionBuilder,
      layoutBuilder: layoutBuilder,
      child: Builder(key: valueKey ?? (useDataAsValueKey ? ValueKey(data) : null), builder: (c) => builder(context, data)),
    );
  }
}
