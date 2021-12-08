import 'package:flutter/material.dart';
import 'dart:math' as math;

extension WidgetExtensions on Widget {
  /// 控件添加点击事件(用GestureDetector包裹)
  Widget addTapEvent(GestureTapCallback? tap) => GestureDetector(onTap: tap, child: this);

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
