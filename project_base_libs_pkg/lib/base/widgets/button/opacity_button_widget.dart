import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/button/base_button_widget.dart';

/// 带透明度动画效果的按钮组件
class OpacityButtonWidget extends StatelessWidget {
  /// 点击事件回调
  final Function onTap;

  /// 按钮是否禁用,默认为false
  final bool disable;

  /// 是否开启动画,默认为true
  final bool enableAnimated;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// margin
  final EdgeInsets? margin;

  /// padding
  final EdgeInsets? padding;

  /// 背景色
  final Color? color;

  /// child
  final Widget? child;

  /// 对齐方式
  final Alignment? alignment;

  /// decoration
  final Decoration? decoration;

  /// foregroundDecoration
  final Decoration? foregroundDecoration;

  /// 动画持续时间
  final Duration? duration;

  /// constraints
  final BoxConstraints? constraints;

  /// transform
  final Matrix4? transform;

  /// transformAlignment
  final Alignment? transformAlignment;

  /// clipBehavior
  final Clip? clipBehavior;

  /// curve
  final Curve? curve;

  /// 高亮状态下的透明度
  final double highlightedOpacity;

  /// 禁用状态下的透明度
  final double disabledOpacity;

  const OpacityButtonWidget({
    Key? key,
    required this.onTap,
    this.disable = false,
    this.enableAnimated = true,
    this.highlightedOpacity = 0.5,
    this.disabledOpacity = 0.2,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.color,
    this.child,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.duration,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior,
    this.curve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
      disable: disable,
      childBuilder: () => _buttonWidget(BaseButtonWidgetStatus.idle),
      highlightedChildBuilder: () => _buttonWidget(BaseButtonWidgetStatus.highlighted),
      disabledChildBuilder: () => _buttonWidget(BaseButtonWidgetStatus.disabled),
      onTap: () => onTap(),
    );
  }

  Widget _buttonWidget(BaseButtonWidgetStatus status) {
    late double opacity;
    switch (status) {
      case BaseButtonWidgetStatus.idle:
        opacity = 1;
        break;
      case BaseButtonWidgetStatus.highlighted:
        opacity = highlightedOpacity;
        break;
      case BaseButtonWidgetStatus.disabled:
        opacity = disabledOpacity;
        break;
    }

    late Duration opacityDuration;
    if (enableAnimated) {
      opacityDuration = duration ?? const Duration(milliseconds: 100);
    } else {
      opacityDuration = Duration.zero;
    }

    return AnimatedOpacity(
      opacity: opacity,
      duration: opacityDuration,
      curve: curve ?? Curves.linear,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        color: color,
        alignment: alignment,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
        constraints: constraints,
        transform: transform,
        transformAlignment: transformAlignment,
        clipBehavior: clipBehavior ?? Clip.none,
        child: child,
      ),
    );
  }
}
