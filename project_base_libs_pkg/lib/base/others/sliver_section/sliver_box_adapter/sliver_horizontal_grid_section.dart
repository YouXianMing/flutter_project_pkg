import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import '../base_sliver_section.dart';
import '../sliver_section.dart';

/// SliverHorizontalGridSection
class SliverHorizontalGridSection extends SliverSection {
  @override
  String? mark;

  @override
  dynamic headerData;

  @override
  SliverSectionHeaderBuilder? headerBuilder;

  @override
  bool? headerSticky;

  @override
  StickyHeaderController? stickyHeaderController;

  @override
  bool? removeHeaderIfHaveNoData;

  @override
  bool? transformToBoxAdapterIfHaveNoData;

  @override
  double? opacity;

  @override
  EdgeInsetsGeometry? padding;

  /// builder
  SliverSectionListItemBuilder? builder;

  /// 数据数组
  List<dynamic>? items;

  /// 子控件水平方向个数,默认为1
  int crossAxisCount;

  /// 子控件水平方向间距,默认为0
  double crossAxisSpacing;

  /// 垂直方向间距,默认为0
  double mainAxisSpacing;

  /// Grid的比例,默认为1
  double childAspectRatio;

  /// 控件高度,必须给
  double height;

  /// 背景色
  Color? backgroundColor;

  SliverHorizontalGridSection({
    required this.height,
    this.mark,
    this.headerData,
    this.headerBuilder,
    this.headerSticky = true,
    this.stickyHeaderController,
    this.removeHeaderIfHaveNoData = true,
    this.transformToBoxAdapterIfHaveNoData = true,
    this.padding,
    this.builder,
    this.items,
    this.crossAxisCount = 1,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.childAspectRatio = 1,
    this.backgroundColor,
    this.opacity,
  });

  static Widget widget({
    required List<dynamic> items,
    required SliverSectionListItemBuilder builder,
    required double height,
    String? mark,
    dynamic headerData,
    SliverSectionHeaderBuilder? headerBuilder,
    bool? headerSticky,
    StickyHeaderController? stickyHeaderController,
    bool? removeHeaderIfHaveNoData,
    bool? transformToBoxAdapterIfHaveNoData,
    EdgeInsetsGeometry? padding,
    int crossAxisCount = 1,
    double crossAxisSpacing = 0,
    double mainAxisSpacing = 0,
    double childAspectRatio = 1,
    Color? backgroundColor,
    double? opacity,
  }) {
    return SliverHorizontalGridSection(
      height: height,
      mark: mark,
      headerData: headerData,
      headerBuilder: headerBuilder,
      headerSticky: headerSticky,
      stickyHeaderController: stickyHeaderController,
      removeHeaderIfHaveNoData: removeHeaderIfHaveNoData,
      transformToBoxAdapterIfHaveNoData: transformToBoxAdapterIfHaveNoData,
      items: items,
      padding: padding,
      builder: builder,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      childAspectRatio: childAspectRatio,
      backgroundColor: backgroundColor,
      opacity: opacity,
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
    assert(builder != null);
    assert(items != null);

    if (transformToBoxAdapterIfHaveNoData == true && items!.isEmpty) {
      return processingBuildWidget(const SliverToBoxAdapter(child: SizedBox()));
    }

    return processingBuildWidget(
      SliverToBoxAdapter(
        child: Container(
          height: height,
          color: backgroundColor,
          child: GridView.builder(
            itemCount: items!.length,
            padding: padding,
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
            ),
            itemBuilder: (c, i) => builder!(c, i, items![i]),
          ),
        ),
      ),
    );
  }

  @override
  Widget processingBuildWidget(Widget widget) {
    // 根据需要构建SliverStickyHeader
    if (removeHeaderIfHaveNoData == true && items!.isEmpty) {
    } else {
      if (headerBuilder != null) {
        widget = SliverStickyHeader(
          header: headerBuilder!(headerData),
          sliver: widget,
          sticky: headerSticky ?? true,
          controller: stickyHeaderController,
        );
      }
    }

    // 如果设置了透明度,则构建SliverOpacity
    if (opacity != null) widget = SliverOpacity(opacity: opacity!, sliver: widget);

    return widget;
  }
}
