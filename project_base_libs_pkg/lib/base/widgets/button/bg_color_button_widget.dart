import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/button/base_button_widget.dart';

class BgColorButtonWidget extends StatelessWidget {
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

  /// 默认状态下的背景色
  final Color idleBgColor;

  /// 高亮状态下的背景色
  final Color highlightedBgColor;

  /// 禁用状态下的背景色
  final Color disabledBgColor;

  const BgColorButtonWidget({
    Key? key,
    required this.onTap,
    this.disable = false,
    this.enableAnimated = true,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.child,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.duration = const Duration(milliseconds: 200),
    this.constraints,
    this.clipBehavior,
    this.curve,
    this.idleBgColor = Colors.white,
    this.highlightedBgColor = Colors.white54,
    this.disabledBgColor = Colors.white54,
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
    late Color color;
    switch (status) {
      case BaseButtonWidgetStatus.idle:
        color = idleBgColor;
        break;
      case BaseButtonWidgetStatus.highlighted:
        color = highlightedBgColor;
        break;
      case BaseButtonWidgetStatus.disabled:
        color = disabledBgColor;
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
      transformAlignment: Alignment.center,
      clipBehavior: clipBehavior ?? Clip.none,
      curve: curve ?? Curves.easeInOut,
      duration: enableAnimated ? duration : Duration.zero,
      child: child,
    );
  }
}
