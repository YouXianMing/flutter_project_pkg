import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/base_scroll_view_builder_config.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/grid_view_builder_config.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/list_view_builder_config.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext? context, int index, dynamic data);

class WidgetsFactory {
  /// ListView.builder构造器
  static ListView listViewBuilder({required ListViewBuilderConfig build}) => build.build() as ListView;

  /// GridView.builder构造器
  static GridView gridViewBuilder({required GridViewBuilderConfig build}) => build.build() as GridView;

  /// ListView或者GridView的builder构造器
  static Widget scrollViewBuilder<T extends BaseScrollViewBuilderConfig>({required T build}) => build.build();

  /// 支持动画效果的Text构造器
  static AnimatedDefaultTextStyle animatedText(
    String data, {
    Key? key,
    double? fontSize,
    int? maxLines,
    Color? color,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    TextAlign? textAlign,
    String? fontFamily, // 字体家族
    double? lineHeight, // 行间距倍数
    double? wordSpacing, // 字体间距
    Duration? duration, // [动画相关参数] 动画时间
    Function()? onEnd, // [动画相关参数] 动画结束回调
    Curve? curve, // [动画相关参数] 动画曲线
  }) {
    return AnimatedDefaultTextStyle(
      key: key,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        height: lineHeight,
        wordSpacing: wordSpacing,
      ),
      duration: duration ?? const Duration(milliseconds: 250),
      onEnd: onEnd,
      curve: curve ?? Curves.linear,
      child: Text(data),
    );
  }

  /// Text构造器
  static Text text(
    String data, {
    Key? key,
    double? fontSize,
    int? maxLines,
    Color? color,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    TextAlign? textAlign,
    String? fontFamily, // 字体家族
    double? lineHeight, // 行间距倍数
    double? wordSpacing, // 字体间距
  }) {
    return Text(
      data,
      key: key,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        height: lineHeight,
        wordSpacing: wordSpacing,
      ),
    );
  }

  /// text与container合集构造器
  static Container textContainer(
    String text, {
    Key? containerKey,
    Key? textKey,
    double? width,
    double? height,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    AlignmentGeometry? alignment,
    Color? backgroundColor,
    Color borderColor = Colors.transparent,
    double borderWidth = 0,
    double borderRadius = 0,
    BorderRadiusGeometry? borderRadiusGeometry,
    BoxBorder? boxBorder,
    Decoration? decoration,
    Color? textColor,
    TextAlign? textAlign,
    TextDirection? textDirection,
    TextOverflow? textOverflow,
    bool? textSoftWrap,
    double? textScaleFactor,
    double? fontSize,
    FontWeight? fontWeight,
    int? textMaxLines,
    String? fontFamily, // 字体家族
    double? lineHeight, // 行间距倍数
    double? wordSpacing, // 字体间距
  }) {
    return Container(
      key: containerKey,
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: decoration ??
          BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadiusGeometry ?? BorderRadius.all(Radius.circular(borderRadius)),
            border: boxBorder ?? Border.all(width: borderWidth, color: borderColor),
          ),
      alignment: alignment,
      child: Text(
        text,
        key: textKey,
        textAlign: textAlign,
        textDirection: textDirection,
        overflow: textOverflow,
        softWrap: textSoftWrap,
        textScaleFactor: textScaleFactor,
        maxLines: textMaxLines,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: lineHeight,
          wordSpacing: wordSpacing,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
