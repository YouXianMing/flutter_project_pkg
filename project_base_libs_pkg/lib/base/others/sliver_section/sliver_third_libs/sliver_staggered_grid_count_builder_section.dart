import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:project_base_libs_pkg/base/third_libs_mod/staggered_grid_view_0_4_0/mod_sliver.dart';
import 'package:project_base_libs_pkg/base/third_libs_mod/staggered_grid_view_0_4_0/mod_staggered_tile.dart';
import 'package:project_base_libs_pkg/base/others/staggered_grid_data.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/base_sliver_section.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/sliver_section.dart';

/// SliverStaggeredGridCountBuilderSection
class SliverStaggeredGridCountBuilderSection<T extends StaggeredGridData> extends SliverSection {
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

  /// 数据数组
  List<T>? items;

  @override
  EdgeInsetsGeometry? padding;

  /// builder
  Widget Function(BuildContext? context, int index, StaggeredGridData data)? builder;

  /// 子控件水平方向个数,默认为2
  int crossAxisCount = 2;

  /// 子控件水平方向间距,默认为0
  double crossAxisSpacing = 0;

  /// 垂直方向间距,默认为0
  double mainAxisSpacing = 0;

  /// 是否使用SliverStaggeredGrid的构建者模式,默认为true
  bool useCountBuilderMode = true;

  SliverStaggeredGridCountBuilderSection({
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
    this.opacity,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.useCountBuilderMode = true,
  }) {
    items ??= [];
  }

  static Widget widget<T extends StaggeredGridData>({
    required List<T> items,
    required Widget Function(BuildContext? context, int index, StaggeredGridData data) builder,
    String? mark,
    dynamic headerData,
    int crossAxisCount = 2,
    double crossAxisSpacing = 0,
    double mainAxisSpacing = 0,
    SliverSectionHeaderBuilder? headerBuilder,
    bool? headerSticky,
    StickyHeaderController? stickyHeaderController,
    bool? removeHeaderIfHaveNoData,
    bool? transformToBoxAdapterIfHaveNoData,
    EdgeInsetsGeometry? padding,
    double? opacity,
    bool useCountBuilderMode = true,
    Key? sliverStaggeredGridKey,
  }) {
    return SliverStaggeredGridCountBuilderSection(
      mark: mark,
      headerData: headerData,
      headerBuilder: headerBuilder,
      headerSticky: headerSticky,
      stickyHeaderController: stickyHeaderController,
      removeHeaderIfHaveNoData: removeHeaderIfHaveNoData,
      transformToBoxAdapterIfHaveNoData: transformToBoxAdapterIfHaveNoData,
      padding: padding,
      builder: builder,
      items: items,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      opacity: opacity,
      useCountBuilderMode: true,
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
    assert(builder != null);
    assert(items != null);

    if (transformToBoxAdapterIfHaveNoData == true && items!.isEmpty) {
      return processingBuildWidget(const SliverToBoxAdapter(child: SizedBox()));
    }

    Widget? widget;
    if (useCountBuilderMode == false) {
      List<Widget> widgets = [];
      List<ModStaggeredTile> tiles = [];
      for (int i = 0; i < items!.length; i++) {
        widgets.add(builder!(null, i, items![i]));
        tiles.add(items![i].tile);
      }

      widget = ModSliverStaggeredGrid.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        staggeredTiles: tiles,
        children: widgets,
      );
    }

    return processingBuildWidget(
      useCountBuilderMode
          ? ModSliverStaggeredGrid.countBuilder(
              crossAxisCount: crossAxisCount,
              staggeredTileBuilder: (index) => items![index].tile,
              itemBuilder: (context, index) => builder!(context, index, items![index]),
              itemCount: items!.length,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
            )
          : widget!,
    );
  }

  @override
  Widget processingBuildWidget(Widget widget) {
    // 根据需要构建SliverPadding
    if (padding != null) widget = SliverPadding(padding: padding!, sliver: widget);

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
