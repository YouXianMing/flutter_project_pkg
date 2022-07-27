import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

/// 用于简化富文本设置用的组件
class RichTextWidget extends StatelessWidget {
  /// 设定的基础的TextStyle,后续的Children都会用到这个基础的TextStyle
  final TextStyle textStyle;

  /// Span数组
  final List<InlineSpan> children;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 文本方向
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  final bool softWrap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// The number of font pixels for each logical pixel.
  final double textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int? maxLines;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  final Locale? locale;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis textWidthBasis;

  /// {@macro dart.ui.textHeightBehavior}
  final TextHeightBehavior? textHeightBehavior;

  const RichTextWidget({
    Key? key,
    required this.textStyle,
    required this.children,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(style: textStyle, children: children),
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}

/// 用于简化Span配置用的类
class SpansFactory {
  /// [TextSpan]的封装,便于使用
  static TextSpan text(
    String text, {
    TextStyle? style,
    GestureRecognizer? recognizer,
    List<InlineSpan>? children,
    Locale? locale,
    bool? spellOut,
  }) {
    return TextSpan(text: text, style: style, recognizer: recognizer, children: children, locale: locale, spellOut: spellOut);
  }

  /// [TextSpan]的简易封装,便于使用
  static TextSpan simpleText(
    String text, {
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    Function()? onTap,
    List<InlineSpan>? children,
    Locale? locale,
    bool? spellOut,
  }) {
    TapGestureRecognizer? tapGestureRecognizer;
    if (onTap != null) {
      tapGestureRecognizer = TapGestureRecognizer();
      tapGestureRecognizer.onTap = onTap;
    }

    return TextSpan(
      text: text,
      style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight, decoration: decoration),
      recognizer: tapGestureRecognizer,
      children: children,
      locale: locale,
      spellOut: spellOut,
    );
  }

  /// [WidgetSpan]的简易封装,便于使用
  static WidgetSpan widget(
    Widget child, {
    TextStyle? style,
    PlaceholderAlignment alignment = ui.PlaceholderAlignment.bottom,
    TextBaseline? baseline,
  }) {
    return WidgetSpan(child: child, style: style, alignment: alignment, baseline: baseline);
  }
}
