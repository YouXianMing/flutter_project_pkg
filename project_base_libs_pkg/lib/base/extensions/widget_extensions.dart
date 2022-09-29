import 'package:flutter/material.dart';
import 'dart:math' as math;

extension WidgetExtensions on Widget {
  /// 控件添加点击事件(用GestureDetector包裹)
  /// 注意:includeContainer为true时,当前控件会被Container包裹之后再被GestureDetector包裹,此时的Container的颜色设置为透明色,被Container包裹的区域均可以响应事件
  Widget addTapEvent(
    GestureTapCallback? tap, {
    bool includeContainer = false,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) =>
      GestureDetector(
        onTap: tap,
        child: includeContainer ? Container(color: Colors.transparent, padding: padding, margin: margin, child: this) : this,
      );

  /// 控件旋转180°
  Widget get rotate180 => Transform.rotate(angle: math.pi, child: this);

  /// 设置为LTR模式(普通布局方式,从左往右排列)
  Widget get setToLTR => Directionality(textDirection: TextDirection.ltr, child: this);

  /// 设置为RTL模式(阿拉伯语的布局方式,从右往左排列)
  Widget get setToRTL => Directionality(textDirection: TextDirection.rtl, child: this);

  /// 添加padding
  Padding addPadding(EdgeInsets padding) => Padding(padding: padding, child: this);

  /// 添加垂直方向的padding
  Padding addVerticalPadding(double value) => Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);

  /// 添加水平方向的padding
  Padding addHorizontalPadding(double value) => Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);

  /// 添加指定方向的padding
  Padding addPaddingOnly({double left = 0, double right = 0, double top = 0, double bottom = 0}) =>
      Padding(padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom), child: this);

  /// 添加Container所有的圆角
  Container addContainerBorderRadius({
    Color? color,
    double? width,
    double? height,
    double radius = 0,
    AlignmentGeometry? alignment,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? borderWidth,
    Color? borderColor,
    BorderStyle? borderStyle,
  }) =>
      Container(
        width: width,
        height: height,
        clipBehavior: Clip.hardEdge,
        padding: padding,
        margin: margin,
        alignment: alignment,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            border: borderWidth != null
                ? Border.all(width: borderWidth, color: borderColor ?? Colors.grey, style: borderStyle ?? BorderStyle.solid)
                : null),
        child: this,
      );

  /// 添加Container独立的圆角
  Container addContainerBorderRadiusOnly({
    Color? color,
    double? width,
    double? height,
    double topLeftRadius = 0,
    double topRightRadius = 0,
    double bottomLeftRadius = 0,
    double bottomRightRadius = 0,
    AlignmentGeometry? alignment,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? borderWidth,
    Color? borderColor,
    BorderStyle? borderStyle,
  }) =>
      Container(
        width: width,
        height: height,
        clipBehavior: Clip.hardEdge,
        padding: padding,
        margin: margin,
        alignment: alignment,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius),
              topRight: Radius.circular(topRightRadius),
              bottomLeft: Radius.circular(bottomLeftRadius),
              bottomRight: Radius.circular(bottomRightRadius),
            ),
            border: borderWidth != null
                ? Border.all(width: borderWidth, color: borderColor ?? Colors.grey, style: borderStyle ?? BorderStyle.solid)
                : null),
        child: this,
      );

  /// 添加Opacity
  Opacity addOpacity(double opacity, {bool alwaysIncludeSemantics = false}) => Opacity(
        opacity: opacity,
        alwaysIncludeSemantics: alwaysIncludeSemantics,
        child: this,
      );

  /// 给Text设置默认的style
  DefaultTextStyle addDefaultTextStyle({
    TextStyle style = const TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 14),
    TextAlign? textAlign,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
    int? maxLines,
    TextWidthBasis textWidthBasis = TextWidthBasis.parent,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return DefaultTextStyle(
        style: style,
        textAlign: textAlign,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        child: this);
  }

  /// (Debug) debug用,给控件添加边框
  Widget addDebugContainer({Color? color, Color? borderColor, double borderWidth = 1}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Colors.red, width: borderWidth),
        color: color ?? Colors.transparent,
      ),
      child: this,
    );
  }
}
