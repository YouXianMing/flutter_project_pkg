import 'package:flutter/material.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext? context, int index, dynamic data);

class WidgetsFactory {
  /// ListView.builder构造器
  static ListView listViewBuilder({required ListViewBuilderConfig build, Key? key}) {
    return ListView.builder(
      key: key,
      padding: build.padding,
      shrinkWrap: build.shrinkWrap,
      physics: build.physics,
      itemCount: build.items.length,
      scrollDirection: build.scrollDirection,
      controller: build.controller,
      keyboardDismissBehavior: build.keyboardDismissBehavior,
      itemBuilder: (c, i) => build.builder(c, i, build.items[i]),
    );
  }

  /// GridView.builder构造器
  static GridView gridViewBuilder({required GridViewBuilderConfig build, Key? key}) {
    return GridView.builder(
      key: key,
      shrinkWrap: build.shrinkWrap,
      physics: build.physics,
      itemCount: build.items.length,
      padding: build.padding,
      scrollDirection: build.scrollDirection,
      controller: build.controller,
      keyboardDismissBehavior: build.keyboardDismissBehavior,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: build.crossAxisCount,
        childAspectRatio: build.childAspectRatio,
        mainAxisSpacing: build.mainAxisSpacing,
        crossAxisSpacing: build.crossAxisSpacing,
      ),
      itemBuilder: (c, i) => build.builder(c, i, build.items[i]),
    );
  }

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

/// listViewBuilder专用
class ListViewBuilderConfig {
  final List<dynamic> items;
  final ItemWidgetBuilder builder;
  final Axis scrollDirection;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final bool shrinkWrap; // shrinkWrap为false会尽可能的填充满parent组件给的空间大小.而shrinkWrap为true则是只满足自身大小。
  final ScrollPhysics? physics; // 确定可滚动控件的物理特性
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior; // 键盘收起操作,默认为手动

  const ListViewBuilderConfig({
    required this.items,
    required this.builder,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.padding = EdgeInsets.zero,
    this.shrinkWrap = false,
    this.physics,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });
}

/// gridViewBuilder专用
class GridViewBuilderConfig {
  final List<dynamic> items;
  final ItemWidgetBuilder builder;
  final Axis scrollDirection;
  final ScrollController? controller;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap; // shrinkWrap为false会尽可能的填充满parent组件给的空间大小.而shrinkWrap为true则是只满足自身大小。
  final ScrollPhysics? physics; // 确定可滚动控件的物理特性
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior; // 键盘收起操作,默认为手动

  const GridViewBuilderConfig({
    required this.items,
    required this.builder,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.crossAxisCount = 1,
    this.childAspectRatio = 1,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.shrinkWrap = false,
    this.physics,
    this.padding = EdgeInsets.zero,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });
}
