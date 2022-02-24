import 'package:flutter/material.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext? context, int index, dynamic data);

class WidgetsFactory {
  /// ListView.builder构造器
  static ListView listViewBuilder({required ListViewBuilderConfig build}) {
    return ListView.builder(
      padding: build.padding,
      shrinkWrap: build.shrinkWrap,
      physics: build.physics,
      itemCount: build.items.length,
      scrollDirection: build.scrollDirection,
      controller: build.controller,
      itemBuilder: (c, i) => build.builder(c, i, build.items[i]),
    );
  }

  /// GridView.builder构造器
  static GridView gridViewBuilder({required GridViewBuilderConfig build}) {
    return GridView.builder(
      shrinkWrap: build.shrinkWrap,
      physics: build.physics,
      itemCount: build.items.length,
      padding: build.padding,
      scrollDirection: build.scrollDirection,
      controller: build.controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: build.crossAxisCount,
        childAspectRatio: build.childAspectRatio,
        mainAxisSpacing: build.mainAxisSpacing,
        crossAxisSpacing: build.crossAxisSpacing,
      ),
      itemBuilder: (c, i) => build.builder(c, i, build.items[i]),
    );
  }

  /// Text的构造器
  static Text text(
    String data, {
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
  List<dynamic> items;
  ItemWidgetBuilder builder;
  Axis scrollDirection;
  ScrollController? controller;
  EdgeInsets? padding;
  bool shrinkWrap; // shrinkWrap为false会尽可能的填充满parent组件给的空间大小.而shrinkWrap为true则是只满足自身大小。
  ScrollPhysics? physics; // 确定可滚动控件的物理特性

  ListViewBuilderConfig({
    required this.items,
    required this.builder,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });
}

/// gridViewBuilder专用
class GridViewBuilderConfig {
  List<dynamic> items;
  ItemWidgetBuilder builder;
  Axis scrollDirection;
  ScrollController? controller;
  int crossAxisCount;
  double childAspectRatio;
  double mainAxisSpacing;
  double crossAxisSpacing;
  EdgeInsetsGeometry? padding;
  bool shrinkWrap; // shrinkWrap为false会尽可能的填充满parent组件给的空间大小.而shrinkWrap为true则是只满足自身大小。
  ScrollPhysics? physics; // 确定可滚动控件的物理特性

  GridViewBuilderConfig({
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
    this.padding,
  });
}
