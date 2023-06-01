import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/button/base_button_widget.dart';

/// 带scale动画效果的按钮组件
class ScaleButtonWidget extends StatelessWidget {
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
  final Duration duration;

  /// constraints
  final BoxConstraints? constraints;

  /// curve
  final Curve? curve;

  /// clipBehavior
  final Clip? clipBehavior;

  /// 默认状态下的缩放值
  final double idleScale;

  /// 高亮状态下的缩放值
  final double highlightedScale;

  /// 禁用状态下的缩放值
  final double disabledScale;

  const ScaleButtonWidget({
    Key? key,
    required this.onTap,
    this.disable = false,
    this.enableAnimated = true,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.color,
    this.child,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.duration = const Duration(milliseconds: 200),
    this.constraints,
    this.clipBehavior,
    this.curve,
    this.idleScale = 1,
    this.highlightedScale = 0.97,
    this.disabledScale = 1,
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
    late double scale;
    switch (status) {
      case BaseButtonWidgetStatus.idle:
        scale = idleScale;
        break;
      case BaseButtonWidgetStatus.highlighted:
        scale = highlightedScale;
        break;
      case BaseButtonWidgetStatus.disabled:
        scale = disabledScale;
        break;
    }

    return AnimatedContainer(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      color: color,
      alignment: alignment,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      constraints: constraints,
      transform: Matrix4.diagonal3Values(scale, scale, 1),
      transformAlignment: Alignment.center,
      clipBehavior: clipBehavior ?? Clip.none,
      curve: curve ?? Curves.decelerate,
      duration: enableAnimated ? duration : Duration.zero,
      child: child,
    );
  }
}
