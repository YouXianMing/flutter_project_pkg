import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import '../base_sliver_section.dart';
import '../sliver_section.dart';

/// SliverQuiltedGridSection
class SliverQuiltedGridSection extends SliverSection with SliverSectionListItemsMixin {
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

  /// 子控件水平方向个数,默认为4
  int crossAxisCount = 4;

  /// 子控件水平方向间距,默认为0
  double crossAxisSpacing = 0;

  /// 垂直方向间距,默认为0
  double mainAxisSpacing = 0;

  /// QuiltedGridTile,该数组不能为空
  List<SliverQuiltedGridTile>? pattern;

  /// 重复的模板
  QuiltedGridSectionRepeatPattern? repeatPattern;

  SliverQuiltedGridSection({
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
    this.crossAxisCount = 4,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.pattern,
    this.repeatPattern,
    this.sliverChildDelegateType = SliverChildDelegateType.builder,
    this.children,
    this.opacity,
  }) {
    items ??= [];
    children ??= [];
    pattern ??= [];
  }

  static Widget builderTypeWidget({
    required List<dynamic> items,
    required SliverSectionListItemBuilder builder,
    required List<SliverQuiltedGridTile>? pattern,
    String? mark,
    dynamic headerData,
    SliverSectionHeaderBuilder? headerBuilder,
    bool? headerSticky,
    StickyHeaderController? stickyHeaderController,
    bool? removeHeaderIfHaveNoData,
    bool? transformToBoxAdapterIfHaveNoData,
    EdgeInsetsGeometry? padding,
    int crossAxisCount = 4,
    double crossAxisSpacing = 0,
    double mainAxisSpacing = 0,
    QuiltedGridSectionRepeatPattern? repeatPattern,
    double? opacity,
  }) {
    return SliverQuiltedGridSection(
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
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      pattern: pattern,
      repeatPattern: repeatPattern,
      opacity: opacity,
    ).buildWidget();
  }

  static Widget staticTypeWidget({
    required List<Widget> children,
    required List<SliverQuiltedGridTile>? pattern,
    String? mark,
    dynamic headerData,
    SliverSectionHeaderBuilder? headerBuilder,
    bool? headerSticky,
    StickyHeaderController? stickyHeaderController,
    bool? removeHeaderIfHaveNoData,
    bool? transformToBoxAdapterIfHaveNoData,
    EdgeInsetsGeometry? padding,
    int crossAxisCount = 4,
    double crossAxisSpacing = 0,
    double mainAxisSpacing = 0,
    QuiltedGridSectionRepeatPattern? repeatPattern,
    double? opacity,
  }) {
    return SliverQuiltedGridSection(
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
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      pattern: pattern,
      repeatPattern: repeatPattern,
      opacity: opacity,
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
    switch (sliverChildDelegateType) {
      case SliverChildDelegateType.static:
        assert(children != null);
        assert(pattern != null && pattern!.isNotEmpty);
        break;
      case SliverChildDelegateType.builder:
        assert(builder != null);
        assert(items != null);
        assert(pattern != null && pattern!.isNotEmpty);
        break;
    }

    if (transformToBoxAdapterIfHaveNoData == true && widgetListIsEmpty) {
      return processingBuildWidget(const SliverToBoxAdapter(child: SizedBox()));
    }

    List<QuiltedGridTile> gridPattern = [];
    for (var element in pattern!) {
      gridPattern.add(QuiltedGridTile(element.mainAxisCount, element.crossAxisCount));
    }

    late QuiltedGridRepeatPattern gridRepeatPattern;
    switch (repeatPattern) {
      case QuiltedGridSectionRepeatPattern.same:
        gridRepeatPattern = QuiltedGridRepeatPattern.same;
        break;
      case QuiltedGridSectionRepeatPattern.inverted:
        gridRepeatPattern = QuiltedGridRepeatPattern.inverted;
        break;
      case QuiltedGridSectionRepeatPattern.mirrored:
        gridRepeatPattern = QuiltedGridRepeatPattern.mirrored;
        break;
      default:
        gridRepeatPattern = QuiltedGridRepeatPattern.same;
    }

    return processingBuildWidget(
      SliverGrid(
        delegate: sliverChildDelegate,
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          repeatPattern: gridRepeatPattern,
          pattern: gridPattern,
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

@immutable
class SliverQuiltedGridTile {
  final int mainAxisCount;
  final int crossAxisCount;

  const SliverQuiltedGridTile(
    this.mainAxisCount,
    this.crossAxisCount,
  )   : assert(mainAxisCount > 0),
        assert(crossAxisCount > 0);

  @override
  String toString() {
    return 'SliverQuiltedGridTile($mainAxisCount, $crossAxisCount)';
  }
}

enum QuiltedGridSectionRepeatPattern {
  same,
  inverted,
  mirrored,
}
