import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import '../base_sliver_section.dart';
import '../sliver_section.dart';

/// SliverGridCrossAxisExtentSection
class SliverGridCrossAxisExtentSection extends SliverSection with SliverSectionListItemsMixin {
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
  List<dynamic>? items;

  /// builder
  @override
  SliverSectionListItemBuilder? builder;

  @override
  SliverChildDelegateType sliverChildDelegateType;

  @override
  List<Widget>? children;

  @override
  EdgeInsetsGeometry? padding;

  /// 子控件在交叉轴上的最大宽度
  double? maxCrossAxisExtent;

  /// 子控件水平方向间距,默认为0
  double crossAxisSpacing = 0;

  /// 垂直方向间距,默认为0
  double mainAxisSpacing = 0;

  /// Grid的比例,默认为1
  double childAspectRatio = 1;

  /// 如果设置了mainAxisExtent,则childAspectRatio会无效
  double? mainAxisExtent;

  SliverGridCrossAxisExtentSection({
    this.mark,
    this.headerData,
    this.headerBuilder,
    this.headerSticky = true,
    this.stickyHeaderController,
    this.removeHeaderIfHaveNoData = true,
    this.transformToBoxAdapterIfHaveNoData = false,
    this.items,
    this.padding,
    this.builder,
    this.maxCrossAxisExtent,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.childAspectRatio = 1,
    this.mainAxisExtent,
    this.sliverChildDelegateType = SliverChildDelegateType.builder,
    this.children,
    this.opacity,
  }) {
    items ??= [];
    children ??= [];
  }

  static Widget builderTypeWidget({
    required List<dynamic> items,
    required SliverSectionListItemBuilder builder,
    required double maxCrossAxisExtent,
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
    double? mainAxisExtent,
    double? opacity,
  }) {
    return SliverGridCrossAxisExtentSection(
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
      sliverChildDelegateType: SliverChildDelegateType.builder,
      maxCrossAxisExtent: maxCrossAxisExtent,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      childAspectRatio: childAspectRatio,
      mainAxisExtent: mainAxisExtent,
      opacity: opacity,
    ).buildWidget();
  }

  static Widget staticTypeWidget({
    required List<Widget> children,
    required double maxCrossAxisExtent,
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
    double? mainAxisExtent,
    double? opacity,
  }) {
    return SliverGridCrossAxisExtentSection(
      mark: mark,
      headerData: headerData,
      headerBuilder: headerBuilder,
      headerSticky: headerSticky,
      stickyHeaderController: stickyHeaderController,
      removeHeaderIfHaveNoData: removeHeaderIfHaveNoData,
      transformToBoxAdapterIfHaveNoData: transformToBoxAdapterIfHaveNoData,
      padding: padding,
      sliverChildDelegateType: SliverChildDelegateType.static,
      children: children,
      maxCrossAxisExtent: maxCrossAxisExtent,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      childAspectRatio: childAspectRatio,
      mainAxisExtent: mainAxisExtent,
      opacity: opacity,
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
    assert(maxCrossAxisExtent != null);
    if (sliverChildDelegateType == SliverChildDelegateType.builder) {
      assert(builder != null);
      assert(items != null);
    } else if (sliverChildDelegateType == SliverChildDelegateType.static) {
      assert(children != null);
    }

    if (transformToBoxAdapterIfHaveNoData == true && widgetListIsEmpty) {
      return processingBuildWidget(const SliverToBoxAdapter(child: SizedBox()));
    }

    return processingBuildWidget(
      SliverGrid(
        delegate: sliverChildDelegate,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent!,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: childAspectRatio,
          mainAxisExtent: mainAxisExtent,
        ),
      ),
    );
  }

  @override
  Widget processingBuildWidget(Widget widget) {
    // 根据需要构建SliverPadding
    if (padding != null) widget = SliverPadding(padding: padding!, sliver: widget);

    // 根据需要构建SliverStickyHeader
    if (removeHeaderIfHaveNoData == true && widgetListIsEmpty) {
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
