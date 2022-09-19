import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/third_libs_mod/staggered_grid_view_0_4_0/mod_staggered_grid_view.dart';
import 'package:project_base_libs_pkg/base/third_libs_mod/staggered_grid_view_0_4_0/mod_staggered_tile.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class StaggeredGridViewCountWidget<T extends StaggeredGridData> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext? context, int index, StaggeredGridData data) builder;
  final int crossAxisCount;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;

  const StaggeredGridViewCountWidget({
    required this.items,
    required this.builder,
    required this.crossAxisCount,
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
  }) : super(key: key);

  static StaggeredGridViewCountWidget inScrollView<T extends StaggeredGridData>({
    required List<T> items,
    required Widget Function(BuildContext? context, int index, StaggeredGridData data) builder,
    required int crossAxisCount,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    EdgeInsetsGeometry? padding,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
  }) {
    return StaggeredGridViewCountWidget(
      items: items,
      builder: builder,
      crossAxisCount: crossAxisCount,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: padding,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ModStaggeredTile> tiles = [];
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      tiles.add(items[i].tile);
      items[i].data;
      widgets.add(builder(context, i, items[i]));
    }

    return ModStaggeredGridView.count(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      staggeredTiles: tiles,
      children: widgets,
    );
  }
}
