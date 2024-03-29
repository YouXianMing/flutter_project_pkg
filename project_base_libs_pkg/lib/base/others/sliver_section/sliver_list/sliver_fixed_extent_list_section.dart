import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/base_sliver_section.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/sliver_section.dart';

/// SliverFixedExtentListSection
class SliverFixedExtentListSection extends SliverSection with SliverSectionListItemsMixin {
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
  SliverSectionListItemBuilder? builder;

  @override
  SliverChildDelegateType sliverChildDelegateType;

  @override
  List<Widget>? children;

  @override
  EdgeInsetsGeometry? padding;

  /// 列表元素的高度
  double? itemExtent;

  SliverFixedExtentListSection({
    this.mark,
    this.headerData,
    this.headerBuilder,
    this.headerSticky = true,
    this.stickyHeaderController,
    this.removeHeaderIfHaveNoData = true,
    this.transformToBoxAdapterIfHaveNoData = false,
    this.itemExtent,
    this.items,
    this.padding,
    this.builder,
    this.sliverChildDelegateType = SliverChildDelegateType.builder,
    this.children,
    this.opacity,
  }) {
    items ??= [];
    children ??= [];
  }

  static Widget builderTypeWidget({
    required double itemExtent,
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
  }) {
    return SliverFixedExtentListSection(
      mark: mark,
      itemExtent: itemExtent,
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
    ).buildWidget();
  }

  static Widget staticTypeWidget({
    required double itemExtent,
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
  }) {
    return SliverFixedExtentListSection(
      mark: mark,
      itemExtent: itemExtent,
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
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
    assert(itemExtent != null);
    switch (sliverChildDelegateType) {
      case SliverChildDelegateType.static:
        assert(children != null);
        break;
      case SliverChildDelegateType.builder:
        assert(builder != null);
        assert(items != null);
        break;
    }

    if (transformToBoxAdapterIfHaveNoData == true && widgetListIsEmpty) {
      return processingBuildWidget(const SliverToBoxAdapter(child: SizedBox()));
    }

    return processingBuildWidget(
      SliverFixedExtentList(itemExtent: itemExtent!, delegate: sliverChildDelegate),
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
