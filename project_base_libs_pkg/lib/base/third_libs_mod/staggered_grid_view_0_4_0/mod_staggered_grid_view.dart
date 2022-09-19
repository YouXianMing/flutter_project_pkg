import 'package:flutter/widgets.dart';

import 'package:project_base_libs_pkg/base/third_libs_mod/staggered_grid_view_0_4_0/mod_sliver.dart';
import 'package:project_base_libs_pkg/base/third_libs_mod/staggered_grid_view_0_4_0/mod_sliver_staggered_grid.dart';
import 'package:project_base_libs_pkg/base/third_libs_mod/staggered_grid_view_0_4_0/mod_staggered_tile.dart';

/// A scrollable, 2D array of widgets with variable sizes.
///
/// The main axis direction of a grid is the direction in which it scrolls (the
/// [scrollDirection]).
///
/// The most commonly used grid layouts are StaggeredGridView.count, which
/// creates a layout with a fixed number of tiles in the cross axis, and
/// StaggeredGridView.extent, which creates a layout with tiles that have a maximum
/// cross-axis extent. A custom [ModSliverStaggeredGridDelegate] can produce an
/// arbitrary 2D arrangement of children.
///
/// To create a grid with a large (or infinite) number of children, use the
/// StaggeredGridView.builder constructor with either a
/// [ModSliverStaggeredGridDelegateWithFixedCrossAxisCount] or a
/// [ModSliverStaggeredGridDelegateWithMaxCrossAxisExtent] for the [gridDelegate].
/// You can also use the StaggeredGridView.countBuilder or
/// StaggeredGridView.extentBuilder constructors.
///
/// To use a custom SliverVariableSizeChildDelegate, use StaggeredGridView.custom.
///
/// To create a linear array of children, use a [ListView].
///
/// To control the initial scroll offset of the scroll view, provide a
/// [controller] with its [ScrollController.initialScrollOffset] property set.
///
/// ### Sample code
///
/// Here are two brief snippets showing a [ModStaggeredGridView] and its equivalent using
/// [CustomScrollView]:
///
/// ```dart
/// StaggeredGridView.count(
///   primary: false,
///   crossAxisCount: 4,
///   mainAxisSpacing: 4.0,
///   crossAxisSpacing: 4.0,
///   children: const <Widget>[
///     const Text('1'),
///     const Text('2'),
///     const Text('3'),
///     const Text('4'),
///     const Text('5'),
///     const Text('6'),
///     const Text('7'),
///     const Text('8'),
///   ],
///   staggeredTiles: const <StaggeredTile>[
///     const StaggeredTile.count(2, 2),
///     const StaggeredTile.count(2, 1),
///     const StaggeredTile.count(2, 2),
///     const StaggeredTile.count(2, 1),
///     const StaggeredTile.count(2, 2),
///     const StaggeredTile.count(2, 1),
///     const StaggeredTile.count(2, 2),
///     const StaggeredTile.count(2, 1),
///   ],
/// )
/// ```
///
/// ```dart
/// CustomScrollView(
///   primary: false,
///   slivers: <Widget>[
///     SliverStaggeredGrid.count(
///       crossAxisCount: 4,
///       mainAxisSpacing: 4.0,
///       crossAxisSpacing: 4.0,
///       children: const <Widget>[
///         const Text('1'),
///         const Text('2'),
///         const Text('3'),
///         const Text('4'),
///         const Text('5'),
///         const Text('6'),
///         const Text('7'),
///         const Text('8'),
///       ],
///       staggeredTiles: const <StaggeredTile>[
///         const StaggeredTile.count(2, 2),
///         const StaggeredTile.count(2, 1),
///         const StaggeredTile.count(2, 2),
///         const StaggeredTile.count(2, 1),
///         const StaggeredTile.count(2, 2),
///         const StaggeredTile.count(2, 1),
///         const StaggeredTile.count(2, 2),
///         const StaggeredTile.count(2, 1),
///       ],
///     )
///   ],
/// )
/// ```
///
/// See also:
///
///  * [SingleChildScrollView], which is a scrollable widget that has a single
///    child.
///  * [ListView], which is scrollable, linear list of widgets.
///  * [PageView], which is a scrolling list of child widgets that are each the
///    size of the viewport.
///  * [CustomScrollView], which is a scrollable widget that creates custom
///    scroll effects using slivers.
///  * [ModSliverStaggeredGridDelegateWithFixedCrossAxisCount], which creates a
///    layout with a fixed number of tiles in the cross axis.
///  * [ModSliverStaggeredGridDelegateWithMaxCrossAxisExtent], which creates a
///    layout with tiles that have a maximum cross-axis extent.
///  * [ScrollNotification] and [NotificationListener], which can be used to watch
///    the scroll position without using a [ScrollController].
class ModStaggeredGridView extends BoxScrollView {
  /// Creates a scrollable, 2D array of widgets with a custom
  /// [ModSliverStaggeredGridDelegate].
  ///
  /// The [gridDelegate] argument must not be null.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// SliverVariableSizeChildListDelegate.addAutomaticKeepAlives property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// SliverVariableSizeChildListDelegate.addRepaintBoundaries property. Both must not be
  /// null.
  ModStaggeredGridView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required this.gridDelegate,
    this.addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    List<Widget> children = const <Widget>[],
    String? restorationId,
  })  : childrenDelegate = SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          restorationId: restorationId,
        );

  /// Creates a scrollable, 2D array of widgets that are created on demand.
  ///
  /// This constructor is appropriate for grid views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Providing a non-null [itemCount] improves the ability of the
  /// [ModSliverStaggeredGridDelegate] to estimate the maximum scroll extent.
  ///
  /// [itemBuilder] will be called only with indices greater than or equal to
  /// zero and less than [itemCount].
  ///
  /// The [gridDelegate] argument must not be null.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// SliverVariableSizeChildBuilderDelegate.addAutomaticKeepAlives property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// SliverVariableSizeChildBuilderDelegate.addRepaintBoundaries property. Both must not
  /// be null.
  ModStaggeredGridView.builder({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required this.gridDelegate,
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    this.addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    String? restorationId,
  })  : childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          restorationId: restorationId,
        );

  /// Creates a scrollable, 2D array of widgets with both a custom
  /// [ModSliverStaggeredGridDelegate] and a custom SliverVariableSizeChildDelegate.
  ///
  /// To use an [IndexedWidgetBuilder] callback to build children, either use
  /// a SliverVariableSizeChildBuilderDelegate or use the
  /// SliverStaggeredGridDelegate.builder constructor.
  ///
  /// The [gridDelegate] and [childrenDelegate] arguments must not be null.
  const ModStaggeredGridView.custom({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    String? restorationId,
    required this.gridDelegate,
    required this.childrenDelegate,
    this.addAutomaticKeepAlives = true,
  }) : super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          restorationId: restorationId,
        );

  /// Creates a scrollable, 2D array of widgets of variable sizes with a fixed
  /// number of tiles in the cross axis.
  ///
  /// Uses a [ModSliverStaggeredGridDelegateWithFixedCrossAxisCount] as the
  /// [gridDelegate].
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// SliverVariableSizeChildListDelegate.addAutomaticKeepAlives property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// SliverVariableSizeChildListDelegate.addRepaintBoundaries property. Both must not be
  /// null.
  ///
  /// See also:
  ///
  ///  * [SliverGrid.count], the equivalent constructor for [SliverGrid].
  ModStaggeredGridView.count({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required int crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    this.addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    List<Widget> children = const <Widget>[],
    List<ModStaggeredTile> staggeredTiles = const <ModStaggeredTile>[],
    String? restorationId,
  })  : gridDelegate = ModSliverStaggeredGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          staggeredTileBuilder: (i) => staggeredTiles[i],
          staggeredTileCount: staggeredTiles.length,
        ),
        childrenDelegate = SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          restorationId: restorationId,
        );

  /// Creates a scrollable, 2D array of widgets of variable sizes with a fixed
  /// number of tiles in the cross axis that are created on demand.
  ///
  /// This constructor is appropriate for grid views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Uses a [ModSliverStaggeredGridDelegateWithFixedCrossAxisCount] as the
  /// [gridDelegate].
  ///
  ///  Providing a non-null [itemCount] improves the ability of the
  /// [ModSliverStaggeredGridDelegate] to estimate the maximum scroll extent.
  ///
  /// [itemBuilder] and [staggeredTileBuilder] will be called only with
  /// indices greater than or equal to
  /// zero and less than [itemCount].
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// SliverVariableSizeChildListDelegate.addAutomaticKeepAlives property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// SliverVariableSizeChildListDelegate.addRepaintBoundaries property. Both must not be
  /// null.
  ModStaggeredGridView.countBuilder({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required int crossAxisCount,
    required IndexedWidgetBuilder itemBuilder,
    required ModIndexedStaggeredTileBuilder staggeredTileBuilder,
    int? itemCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    this.addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    String? restorationId,
  })  : gridDelegate = ModSliverStaggeredGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          staggeredTileBuilder: staggeredTileBuilder,
          staggeredTileCount: itemCount,
        ),
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          restorationId: restorationId,
        );

  /// Creates a scrollable, 2D array of widgets of variable sizes with tiles
  /// that  each have a maximum cross-axis extent.
  ///
  /// Uses a [SliverGridDelegateWithMaxCrossAxisExtent] as the [gridDelegate].
  ///
  ///  Providing a non-null itemCount improves the ability of the
  /// [ModSliverStaggeredGridDelegate] to estimate the maximum scroll extent.
  ///
  /// itemBuilder and staggeredTileBuilder will be called only with
  /// indices greater than or equal to
  /// zero and less than itemCount.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// SliverVariableSizeChildListDelegate.addAutomaticKeepAlives property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// SliverVariableSizeChildListDelegate.addRepaintBoundaries property. Both must not be
  /// null.
  ///
  /// See also:
  ///
  ///  * [SliverGrid.extent], the equivalent constructor for [SliverGrid].
  ModStaggeredGridView.extent({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required double maxCrossAxisExtent,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    this.addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    List<Widget> children = const <Widget>[],
    List<ModStaggeredTile> staggeredTiles = const <ModStaggeredTile>[],
    String? restorationId,
  })  : gridDelegate = ModSliverStaggeredGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          staggeredTileBuilder: (i) => staggeredTiles[i],
          staggeredTileCount: staggeredTiles.length,
        ),
        childrenDelegate = SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          restorationId: restorationId,
        );

  /// Creates a scrollable, 2D array of widgets of variable sizes with tiles
  /// that  each have a maximum cross-axis extent that are created on demand.
  ///
  /// This constructor is appropriate for grid views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Uses a [SliverGridDelegateWithMaxCrossAxisExtent] as the [gridDelegate].
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// SliverVariableSizeChildListDelegate.addAutomaticKeepAlives property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// SliverVariableSizeChildListDelegate.addRepaintBoundaries property. Both must not be
  /// null.
  ///
  /// See also:
  ///
  ///  * [SliverGrid.extent], the equivalent constructor for [SliverGrid].
  ModStaggeredGridView.extentBuilder({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required double maxCrossAxisExtent,
    required IndexedWidgetBuilder itemBuilder,
    required ModIndexedStaggeredTileBuilder staggeredTileBuilder,
    int? itemCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    this.addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    String? restorationId,
  })  : gridDelegate = ModSliverStaggeredGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          staggeredTileBuilder: staggeredTileBuilder,
          staggeredTileCount: itemCount,
        ),
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          restorationId: restorationId,
        );

  /// A delegate that controls the layout of the children within the
  /// [ModStaggeredGridView].
  ///
  /// The [ModStaggeredGridView] and StaggeredGridView.custom constructors let you specify this
  /// delegate explicitly. The other constructors create a [gridDelegate]
  /// implicitly.
  final ModSliverStaggeredGridDelegate gridDelegate;

  /// A delegate that provides the children for the [ModStaggeredGridView].
  ///
  /// The StaggeredGridView.custom constructor lets you specify this delegate
  /// explicitly. The other constructors create a [childrenDelegate] that wraps
  /// the given child list.
  final SliverChildDelegate childrenDelegate;

  /// Whether to add keepAlives to children
  final bool addAutomaticKeepAlives;

  @override
  Widget buildChildLayout(BuildContext context) {
    return ModSliverStaggeredGrid(
      delegate: childrenDelegate,
      gridDelegate: gridDelegate,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
    );
  }
}
