import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import '../base_sliver_section.dart';
import '../sliver_section.dart';

/// SliverWaterfallFlowSection
class SliverWaterfallFlowSection extends SliverSection with SliverSectionListItemsMixin {
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

  @override
  EdgeInsetsGeometry? padding;

  @override
  SliverSectionListItemBuilder? builder;

  @override
  List<Widget>? children;

  @override
  SliverChildDelegateType sliverChildDelegateType;

  /// 子控件水平方向个数,默认为2
  int crossAxisCount = 2;

  /// 子控件水平方向间距,默认为0
  double crossAxisSpacing = 0;

  /// 垂直方向间距,默认为0
  double mainAxisSpacing = 0;

  SliverWaterfallFlowSection({
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
    this.sliverChildDelegateType = SliverChildDelegateType.builder,
    this.children,
    this.opacity,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
  }) {
    items ??= [];
    children ??= [];
  }

  static Widget builderTypeWidget({
    required List<dynamic> items,
    required SliverSectionListItemBuilder builder,
    String? mark,
    dynamic headerData,
    SliverSectionHeaderBuilder? headerBuilder,
    bool? headerSticky,
    StickyHeaderController? stickyHeaderController,
    bool? removeHeaderIfHaveNoData,
    bool? transformToBoxAdapterIfHaveNoData,
    EdgeInsetsGeometry? padding,
    double? opacity,
    int crossAxisCount = 2,
    double crossAxisSpacing = 0,
    double mainAxisSpacing = 0,
  }) {
    return SliverWaterfallFlowSection(
      mark: mark,
      headerData: headerData,
      headerBuilder: headerBuilder,
      headerSticky: headerSticky,
      stickyHeaderController: stickyHeaderController,
      removeHeaderIfHaveNoData: removeHeaderIfHaveNoData,
      transformToBoxAdapterIfHaveNoData: transformToBoxAdapterIfHaveNoData,
      padding: padding,
      builder: builder,
      sliverChildDelegateType: SliverChildDelegateType.builder,
      items: items,
      opacity: opacity,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
    ).buildWidget();
  }

  static Widget staticTypeWidget({
    required List<Widget> children,
    String? mark,
    dynamic headerData,
    SliverSectionHeaderBuilder? headerBuilder,
    bool? headerSticky,
    StickyHeaderController? stickyHeaderController,
    bool? removeHeaderIfHaveNoData,
    bool? transformToBoxAdapterIfHaveNoData,
    EdgeInsetsGeometry? padding,
    double? opacity,
    int crossAxisCount = 2,
    double crossAxisSpacing = 0,
    double mainAxisSpacing = 0,
  }) {
    return SliverWaterfallFlowSection(
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
      opacity: opacity,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
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
      SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        ),
        delegate: sliverChildDelegate,
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
