import 'package:flutter/gestures.dart';
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
    void Function(LongPressDownDetails)? onLongPressDown,
    void Function()? onLongPressCancel,
    void Function()? onLongPress,
    void Function(LongPressStartDetails)? onLongPressStart,
    Key? key,
  }) =>
      GestureDetector(
        key: key,
        onTap: tap,
        onLongPressDown: onLongPressDown,
        onLongPressCancel: onLongPressCancel,
        onLongPress: onLongPress,
        onLongPressStart: onLongPressStart,
        child: includeContainer ? Container(color: Colors.transparent, padding: padding, margin: margin, child: this) : this,
      );

  /// 控件旋转180°
  Widget get rotate180 => Transform.rotate(angle: math.pi, child: this);

  /// 设置控件顺时针旋转指定的度数,比如设置degrees=30表示顺时针旋转30°
  Widget setRotate({required double degrees}) => Transform.rotate(angle: degrees * math.pi / 180, child: this);

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
    Key? key,
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
        key: key,
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
    Key? key,
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
        key: key,
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

  /// 给Text设置默认的style(一般用于加载在Overlay上的组件)
  DefaultTextStyle addDefaultTextStyle({
    Key? key,
    TextStyle style = const TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 14),
    TextAlign? textAlign,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
    int? maxLines,
    TextWidthBasis textWidthBasis = TextWidthBasis.parent,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return DefaultTextStyle(
        key: key,
        style: style,
        textAlign: textAlign,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        child: this);
  }

  /// 加入到center组件
  Widget addCenter() => Center(child: this);

  /// 加入到Align组件
  Widget addAlign({AlignmentGeometry alignment = Alignment.center, double? widthFactor, double? heightFactor}) => Align(
        alignment: alignment,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );

  /// 加入到Transform.translate组件(文档流里的布局不受影响)
  Widget addTransformTranslate({double x = 0, double y = 0}) => Transform.translate(offset: Offset(x, y), child: this);

  /// 加入到Visibility(显示或隐藏组件)中
  Widget addVisibility({
    required bool visible,
    bool maintainState = false,
    bool maintainAnimation = false,
    bool maintainSize = false,
    bool maintainSemantics = false,
    bool maintainInteractivity = false,
  }) =>
      Visibility(
        visible: visible,
        maintainState: maintainState,
        maintainAnimation: maintainAnimation,
        maintainSize: maintainSize,
        maintainSemantics: maintainSemantics,
        maintainInteractivity: maintainInteractivity,
        child: this,
      );

  /// 加入到Opacity(设置透明度)组件
  Opacity addOpacity(double opacity, {bool alwaysIncludeSemantics = false}) => Opacity(
        opacity: opacity,
        alwaysIncludeSemantics: alwaysIncludeSemantics,
        child: this,
      );

  /// 加入到Offstage(显示或隐藏组件)中
  Widget addOffstage({required bool offstage}) => Offstage(offstage: offstage, child: this);

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
