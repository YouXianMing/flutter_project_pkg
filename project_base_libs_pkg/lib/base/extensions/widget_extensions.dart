import 'package:flutter/material.dart';
import 'dart:math' as math;

extension WidgetExtensions on Widget {
  /// 控件添加点击事件(用GestureDetector包裹)
  /// 注意:includeContainer为true时,当前控件会被Container包裹之后再被GestureDetector包裹,此时的Container的颜色设置为透明色,被Container包裹的区域均可以响应事件
  Widget addTapEvent(
    GestureTapCallback? tap, {
    bool includeContainer = false,
  }) =>
      GestureDetector(onTap: tap, child: includeContainer ? Container(color: Colors.transparent, child: this) : this);

  /// 控件旋转180°
  Widget get rotate180 => Transform.rotate(angle: math.pi, child: this);

  /// 添加padding
  Padding addPadding(EdgeInsets padding) => Padding(padding: padding, child: this);

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
