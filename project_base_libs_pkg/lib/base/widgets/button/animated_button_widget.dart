import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/button/base_button_widget.dart';

class AnimatedButtonWidgetStatus {
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

  AnimatedButtonWidgetStatus({
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
  });
}

class AnimatedButtonWidget extends StatelessWidget {
  /// 正常状态
  final AnimatedButtonWidgetStatus normalStatus;

  /// 高亮状态
  final AnimatedButtonWidgetStatus highlightedStatus;

  /// 禁用状态
  final AnimatedButtonWidgetStatus disableStatus;

  /// 点击事件回调
  final Function onTap;

  /// 按钮是否禁用,默认为false
  final bool disable;

  /// 是否开启动画,默认为true
  final bool enableAnimated;

  const AnimatedButtonWidget({
    Key? key,
    required this.normalStatus,
    required this.highlightedStatus,
    required this.disableStatus,
    required this.onTap,
    this.disable = false,
    this.enableAnimated = true,
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
    double? width;
    double? height;
    EdgeInsets? margin;
    EdgeInsets? padding;
    Alignment? alignment;
    Color? color;
    Decoration? decoration;
    Decoration? foregroundDecoration;
    Widget? child;
    Duration? duration;
    BoxConstraints? constraints;
    Matrix4? transform;
    Alignment? transformAlignment;
    Clip? clipBehavior;
    Curve? curve;

    switch (status) {
      case BaseButtonWidgetStatus.idle:
        width = normalStatus.width;
        height = normalStatus.height;
        margin = normalStatus.margin;
        padding = normalStatus.padding;
        alignment = normalStatus.alignment;
        color = normalStatus.color;
        decoration = normalStatus.decoration;
        foregroundDecoration = normalStatus.foregroundDecoration;
        child = normalStatus.child;
        duration = normalStatus.duration;
        constraints = normalStatus.constraints;
        transform = normalStatus.transform;
        transformAlignment = normalStatus.transformAlignment;
        clipBehavior = normalStatus.clipBehavior;
        curve = normalStatus.curve;
        break;
      case BaseButtonWidgetStatus.highlighted:
        width = highlightedStatus.width;
        height = highlightedStatus.height;
        margin = highlightedStatus.margin;
        padding = highlightedStatus.padding;
        alignment = highlightedStatus.alignment;
        color = highlightedStatus.color;
        decoration = highlightedStatus.decoration;
        foregroundDecoration = highlightedStatus.foregroundDecoration;
        child = highlightedStatus.child;
        duration = highlightedStatus.duration;
        constraints = highlightedStatus.constraints;
        transform = highlightedStatus.transform;
        transformAlignment = highlightedStatus.transformAlignment;
        clipBehavior = highlightedStatus.clipBehavior;
        curve = highlightedStatus.curve;
        break;
      case BaseButtonWidgetStatus.disabled:
        width = disableStatus.width;
        height = disableStatus.height;
        margin = disableStatus.margin;
        padding = disableStatus.padding;
        alignment = disableStatus.alignment;
        color = disableStatus.color;
        decoration = disableStatus.decoration;
        foregroundDecoration = disableStatus.foregroundDecoration;
        child = disableStatus.child;
        duration = disableStatus.duration;
        constraints = disableStatus.constraints;
        transform = disableStatus.transform;
        transformAlignment = disableStatus.transformAlignment;
        clipBehavior = disableStatus.clipBehavior;
        curve = disableStatus.curve;
        break;
    }

    if (enableAnimated) {
      return AnimatedContainer(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        alignment: alignment,
        duration: duration ?? Duration.zero,
        color: color,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
        constraints: constraints,
        transform: transform,
        transformAlignment: transformAlignment,
        clipBehavior: clipBehavior ?? Clip.none,
        curve: curve ?? Curves.linear,
        child: child,
      );
    } else {
      return Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        alignment: alignment,
        color: color,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
        constraints: constraints,
        transform: transform,
        transformAlignment: transformAlignment,
        clipBehavior: clipBehavior ?? Clip.none,
        child: child,
      );
    }
  }
}
