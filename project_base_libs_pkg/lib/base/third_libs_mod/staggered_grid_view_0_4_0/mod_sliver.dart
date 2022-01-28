import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'mod_sliver_staggered_grid.dart';
import 'mod_sliver_variable_size_box_adaptor.dart';
import 'mod_staggered_tile.dart';

/// A base class for sliver that have multiple variable size box children.
///
/// Helps subclasses build their children lazily using a SliverVariableSizeChildDelegate.
abstract class ModSliverVariableSizeBoxAdaptorWidget extends SliverWithKeepAliveWidget {
  /// Initializes fields for subclasses.
  const ModSliverVariableSizeBoxAdaptorWidget({
    Key? key,
    required this.delegate,
    this.addAutomaticKeepAlives = true,
  }) : super(key: key);

  /// Whether to add keepAlives to children
  final bool addAutomaticKeepAlives;

  /// The delegate that provides the children for this widget.
  ///
  /// The children are constructed lazily using this widget to avoid creating
  /// more children than are visible through the [Viewport].
  ///
  /// See also:
  ///
  ///  * [SliverChildBuilderDelegate] and [SliverChildListDelegate], which are
  ///    commonly used subclasses of [SliverChildDelegate] that use a builder
  ///    callback and an explicit child list, respectively.
  final SliverChildDelegate delegate;

  @override
  ModSliverVariableSizeBoxAdaptorElement createElement() => ModSliverVariableSizeBoxAdaptorElement(
        this,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
      );

  @override
  ModRenderSliverVariableSizeBoxAdaptor createRenderObject(BuildContext context);

  /// Returns an estimate of the max scroll extent for all the children.
  ///
  /// Subclasses should override this function if they have additional
  /// information about their max scroll extent.
  ///
  /// This is used by [SliverMultiBoxAdaptorElement] to implement part of the
  /// [RenderSliverBoxChildManager] API.
  ///
  /// The default implementation defers to [delegate] via its
  /// [SliverChildDelegate.estimateMaxScrollOffset] method.
  double? estimateMaxScrollOffset(
    SliverConstraints constraints,
    int firstIndex,
    int lastIndex,
    double leadingScrollOffset,
    double trailingScrollOffset,
  ) {
    assert(lastIndex >= firstIndex);
    return delegate.estimateMaxScrollOffset(
      firstIndex,
      lastIndex,
      leadingScrollOffset,
      trailingScrollOffset,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<SliverChildDelegate>('delegate', delegate),
    );
  }
}

/// An element that lazily builds children for a [ModSliverVariableSizeBoxAdaptorWidget].
///
/// Implements [ModRenderSliverVariableSizeBoxChildManager], which lets this element manage
/// the children of subclasses of [ModRenderSliverVariableSizeBoxAdaptor].
class ModSliverVariableSizeBoxAdaptorElement extends RenderObjectElement implements ModRenderSliverVariableSizeBoxChildManager {
  /// Creates an element that lazily builds children for the given widget.
  ModSliverVariableSizeBoxAdaptorElement(ModSliverVariableSizeBoxAdaptorWidget widget, {this.addAutomaticKeepAlives = true}) : super(widget);

  /// Whether to add keepAlives to children
  final bool addAutomaticKeepAlives;

  @override
  ModSliverVariableSizeBoxAdaptorWidget get widget => super.widget as ModSliverVariableSizeBoxAdaptorWidget;

  @override
  ModRenderSliverVariableSizeBoxAdaptor get renderObject => super.renderObject as ModRenderSliverVariableSizeBoxAdaptor;

  @override
  void update(covariant ModSliverVariableSizeBoxAdaptorWidget newWidget) {
    final ModSliverVariableSizeBoxAdaptorWidget oldWidget = widget;
    super.update(newWidget);
    final SliverChildDelegate newDelegate = newWidget.delegate;
    final SliverChildDelegate oldDelegate = oldWidget.delegate;
    if (newDelegate != oldDelegate && (newDelegate.runtimeType != oldDelegate.runtimeType || newDelegate.shouldRebuild(oldDelegate))) {
      performRebuild();
    }
  }

  // We inflate widgets at two different times:
  //  1. When we ourselves are told to rebuild (see performRebuild).
  //  2. When our render object needs a child (see createChild).
  // In both cases, we cache the results of calling into our delegate to get the widget,
  // so that if we do case 2 later, we don't call the builder again.
  // Any time we do case 1, though, we reset the cache.

  final Map<int, Widget?> _childWidgets = HashMap<int, Widget?>();
  final SplayTreeMap<int, Element> _childElements = SplayTreeMap<int, Element>();

  @override
  void performRebuild() {
    _childWidgets.clear(); // Reset the cache, as described above.
    super.performRebuild();
    assert(_currentlyUpdatingChildIndex == null);
    try {
      late final int firstIndex;
      late final int lastIndex;
      if (_childElements.isEmpty) {
        firstIndex = 0;
        lastIndex = 0;
      } else if (_didUnderflow) {
        firstIndex = _childElements.firstKey()!;
        lastIndex = _childElements.lastKey()! + 1;
      } else {
        firstIndex = _childElements.firstKey()!;
        lastIndex = _childElements.lastKey()!;
      }

      for (int index = firstIndex; index <= lastIndex; ++index) {
        _currentlyUpdatingChildIndex = index;
        final Element? newChild = updateChild(_childElements[index], _build(index), index);
        if (newChild != null) {
          _childElements[index] = newChild;
        } else {
          _childElements.remove(index);
        }
      }
    } finally {
      _currentlyUpdatingChildIndex = null;
    }
  }

  Widget? _build(int index) {
    return _childWidgets.putIfAbsent(index, () => widget.delegate.build(this, index));
  }

  @override
  void createChild(int index) {
    assert(_currentlyUpdatingChildIndex == null);
    owner!.buildScope(this, () {
      Element? newChild;
      try {
        _currentlyUpdatingChildIndex = index;
        newChild = updateChild(_childElements[index], _build(index), index);
      } finally {
        _currentlyUpdatingChildIndex = null;
      }
      if (newChild != null) {
        _childElements[index] = newChild;
      } else {
        _childElements.remove(index);
      }
    });
  }

  @override
  Element? updateChild(Element? child, Widget? newWidget, dynamic newSlot) {
    final oldParentData = child?.renderObject?.parentData as ModSliverVariableSizeBoxAdaptorParentData?;
    final Element? newChild = super.updateChild(child, newWidget, newSlot);
    final newParentData = newChild?.renderObject?.parentData as ModSliverVariableSizeBoxAdaptorParentData?;

    // set keepAlive to true in order to populate the cache
    if (addAutomaticKeepAlives && newParentData != null) {
      newParentData.keepAlive = true;
    }

    // Preserve the old layoutOffset if the renderObject was swapped out.
    if (oldParentData != newParentData && oldParentData != null && newParentData != null) {
      newParentData.layoutOffset = oldParentData.layoutOffset;
    }

    return newChild;
  }

  @override
  void forgetChild(Element child) {
    assert(child.slot != null);
    assert(_childElements.containsKey(child.slot));
    _childElements.remove(child.slot);
    super.forgetChild(child);
  }

  @override
  void removeChild(RenderBox child) {
    final int index = renderObject.indexOf(child);
    assert(_currentlyUpdatingChildIndex == null);
    assert(index >= 0);
    owner!.buildScope(this, () {
      assert(_childElements.containsKey(index));
      try {
        _currentlyUpdatingChildIndex = index;
        final Element? result = updateChild(_childElements[index], null, index);
        assert(result == null);
      } finally {
        _currentlyUpdatingChildIndex = null;
      }
      _childElements.remove(index);
      assert(!_childElements.containsKey(index));
    });
  }

  double? _extrapolateMaxScrollOffset(
    int? firstIndex,
    int? lastIndex,
    double? leadingScrollOffset,
    double? trailingScrollOffset,
  ) {
    final int? childCount = widget.delegate.estimatedChildCount;
    if (childCount == null) {
      return double.infinity;
    }
    if (lastIndex == childCount - 1) {
      return trailingScrollOffset;
    }
    final int reifiedCount = lastIndex! - firstIndex! + 1;
    final double averageExtent = (trailingScrollOffset! - leadingScrollOffset!) / reifiedCount;
    final int remainingCount = childCount - lastIndex - 1;
    return trailingScrollOffset + averageExtent * remainingCount;
  }

  @override
  double estimateMaxScrollOffset(
    SliverConstraints constraints, {
    int? firstIndex,
    int? lastIndex,
    double? leadingScrollOffset,
    double? trailingScrollOffset,
  }) {
    return widget.estimateMaxScrollOffset(
          constraints,
          firstIndex!,
          lastIndex!,
          leadingScrollOffset!,
          trailingScrollOffset!,
        ) ??
        _extrapolateMaxScrollOffset(
          firstIndex,
          lastIndex,
          leadingScrollOffset,
          trailingScrollOffset,
        )!;
  }

  @override
  int get childCount => widget.delegate.estimatedChildCount ?? 0;

  @override
  void didStartLayout() {
    assert(debugAssertChildListLocked());
  }

  @override
  void didFinishLayout() {
    assert(debugAssertChildListLocked());
    final int firstIndex = _childElements.firstKey() ?? 0;
    final int lastIndex = _childElements.lastKey() ?? 0;
    widget.delegate.didFinishLayout(firstIndex, lastIndex);
  }

  int? _currentlyUpdatingChildIndex;

  @override
  bool debugAssertChildListLocked() {
    assert(_currentlyUpdatingChildIndex == null);
    return true;
  }

  @override
  void didAdoptChild(RenderBox child) {
    assert(_currentlyUpdatingChildIndex != null);
    final childParentData = child.parentData! as ModSliverVariableSizeBoxAdaptorParentData;
    childParentData.index = _currentlyUpdatingChildIndex;
  }

  bool _didUnderflow = false;

  @override
  void setDidUnderflow(bool value) {
    _didUnderflow = value;
  }

  @override
  void insertRenderObjectChild(covariant RenderBox child, int slot) {
    assert(_currentlyUpdatingChildIndex == slot);
    assert(renderObject.debugValidateChild(child));
    renderObject[_currentlyUpdatingChildIndex!] = child;
    assert(() {
      final childParentData = child.parentData! as ModSliverVariableSizeBoxAdaptorParentData;
      assert(slot == childParentData.index);
      return true;
    }());
  }

  @override
  void moveRenderObjectChild(
    covariant RenderObject child,
    covariant Object? oldSlot,
    covariant Object? newSlot,
  ) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(
    covariant RenderObject child,
    covariant Object? slot,
  ) {
    assert(_currentlyUpdatingChildIndex != null);
    renderObject.remove(_currentlyUpdatingChildIndex!);
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    // The toList() is to make a copy so that the underlying list can be modified by
    // the visitor:
    _childElements.values.toList().forEach(visitor);
  }

  @override
  void debugVisitOnstageChildren(ElementVisitor visitor) {
    _childElements.values.where((Element child) {
      final parentData = child.renderObject!.parentData as SliverMultiBoxAdaptorParentData?;
      late double itemExtent;
      switch (renderObject.constraints.axis) {
        case Axis.horizontal:
          itemExtent = child.renderObject!.paintBounds.width;
          break;
        case Axis.vertical:
          itemExtent = child.renderObject!.paintBounds.height;
          break;
      }

      return parentData!.layoutOffset! < renderObject.constraints.scrollOffset + renderObject.constraints.remainingPaintExtent &&
          parentData.layoutOffset! + itemExtent > renderObject.constraints.scrollOffset;
    }).forEach(visitor);
  }
}

/// A sliver that places multiple box children in a two dimensional arrangement.
///
/// [ModSliverStaggeredGrid] places its children in arbitrary positions determined by
/// [gridDelegate]. Each child is forced to have the size specified by the
/// [gridDelegate].
///
/// The main axis direction of a grid is the direction in which it scrolls; the
/// cross axis direction is the orthogonal direction.
///
/// ## Sample code
///
/// This example, which would be inserted into a [CustomScrollView.slivers]
/// list, shows 8 boxes:
///
/// ```dart
///SliverStaggeredGrid.count(
///  crossAxisCount: 4,
///  mainAxisSpacing: 4.0,
///  crossAxisSpacing: 4.0,
///  children: const <Widget>[
///    const Text('1'),
///    const Text('2'),
///    const Text('3'),
///    const Text('4'),
///    const Text('5'),
///    const Text('6'),
///    const Text('7'),
///    const Text('8'),
///  ],
///  staggeredTiles: const <StaggeredTile>[
///    const StaggeredTile.count(2, 2),
///    const StaggeredTile.count(2, 1),
///    const StaggeredTile.count(2, 2),
///    const StaggeredTile.count(2, 1),
///    const StaggeredTile.count(2, 2),
///    const StaggeredTile.count(2, 1),
///    const StaggeredTile.count(2, 2),
///    const StaggeredTile.count(2, 1),
///  ],
///)
/// ```
///
/// See also:
///
///  * [SliverList], which places its children in a linear array.
///  * [SliverFixedExtentList], which places its children in a linear
///    array with a fixed extent in the main axis.
///  * [SliverPrototypeExtentList], which is similar to [SliverFixedExtentList]
///    except that it uses a prototype list item instead of a pixel value to define
///    the main axis extent of each item.
class ModSliverStaggeredGrid extends ModSliverVariableSizeBoxAdaptorWidget {
  /// Creates a sliver that places multiple box children in a two dimensional
  /// arrangement.
  const ModSliverStaggeredGrid({
    Key? key,
    required SliverChildDelegate delegate,
    required this.gridDelegate,
    bool addAutomaticKeepAlives = true,
  }) : super(
          key: key,
          delegate: delegate,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
        );

  /// Creates a sliver that places multiple box children in a two dimensional
  /// arrangement with a fixed number of tiles in the cross axis.
  ///
  /// Uses a SliverStaggeredGridDelegateWithFixedCrossAxisCount as the [gridDelegate],
  /// and a SliverVariableSizeChildListDelegate as the [delegate].
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  //  [SliverVariableSizeChildListDelegate.addAutomaticKeepAlives] property. The
  ///
  /// See also:
  ///
  ///  * StaggeredGridView.count, the equivalent constructor for StaggeredGridView widgets.
  ModSliverStaggeredGrid.count({
    Key? key,
    required int crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    List<Widget> children = const <Widget>[],
    List<ModStaggeredTile> staggeredTiles = const <ModStaggeredTile>[],
    bool addAutomaticKeepAlives = true,
  })  : gridDelegate = ModSliverStaggeredGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          staggeredTileBuilder: (i) => staggeredTiles[i],
          staggeredTileCount: staggeredTiles.length,
        ),
        super(
          key: key,
          delegate: SliverChildListDelegate(
            children,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
          ),
        );

  /// Creates a sliver that builds multiple box children in a two dimensional
  /// arrangement with a fixed number of tiles in the cross axis.
  ///
  /// This constructor is appropriate for grid views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Uses a [ModSliverStaggeredGridDelegateWithFixedCrossAxisCount] as the
  /// [gridDelegate], and a SliverVariableSizeChildBuilderDelegate as the [delegate].
  ///
  /// See also:
  ///
  ///  * StaggeredGridView.countBuilder, the equivalent constructor for
  ///  StaggeredGridView widgets.
  ModSliverStaggeredGrid.countBuilder({
    Key? key,
    required int crossAxisCount,
    required ModIndexedStaggeredTileBuilder staggeredTileBuilder,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    bool addAutomaticKeepAlives = true,
  })  : gridDelegate = ModSliverStaggeredGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          staggeredTileBuilder: staggeredTileBuilder,
          staggeredTileCount: itemCount,
        ),
        super(
          key: key,
          delegate: SliverChildBuilderDelegate(
            itemBuilder,
            childCount: itemCount,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
          ),
        );

  /// Creates a sliver that places multiple box children in a two dimensional
  /// arrangement with tiles that each have a maximum cross-axis extent.
  ///
  /// Uses a [ModSliverStaggeredGridDelegateWithMaxCrossAxisExtent] as the [gridDelegate],
  /// and a SliverVariableSizeChildListDelegate as the [delegate].
  ///
  /// See also:
  ///
  ///  * StaggeredGridView.extent, the equivalent constructor for StaggeredGridView widgets.
  ModSliverStaggeredGrid.extent({
    Key? key,
    required double maxCrossAxisExtent,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    List<Widget> children = const <Widget>[],
    List<ModStaggeredTile> staggeredTiles = const <ModStaggeredTile>[],
    bool addAutomaticKeepAlives = true,
  })  : gridDelegate = ModSliverStaggeredGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          staggeredTileBuilder: (i) => staggeredTiles[i],
          staggeredTileCount: staggeredTiles.length,
        ),
        super(
          key: key,
          delegate: SliverChildListDelegate(
            children,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
          ),
        );

  /// Creates a sliver that builds multiple box children in a two dimensional
  /// arrangement with tiles that each have a maximum cross-axis extent.
  ///
  /// This constructor is appropriate for grid views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Uses a [ModSliverStaggeredGridDelegateWithMaxCrossAxisExtent] as the
  /// [gridDelegate], and a SliverVariableSizeChildBuilderDelegate as the [delegate].
  ///
  /// See also:
  ///
  ///  * StaggeredGridView.extentBuilder, the equivalent constructor for
  ///  StaggeredGridView widgets.
  ModSliverStaggeredGrid.extentBuilder({
    Key? key,
    required double maxCrossAxisExtent,
    required ModIndexedStaggeredTileBuilder staggeredTileBuilder,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    bool addAutomaticKeepAlives = true,
  })  : gridDelegate = ModSliverStaggeredGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          staggeredTileBuilder: staggeredTileBuilder,
          staggeredTileCount: itemCount,
        ),
        super(
          key: key,
          delegate: SliverChildBuilderDelegate(
            itemBuilder,
            childCount: itemCount,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
          ),
        );

  /// The delegate that controls the size and position of the children.
  final ModSliverStaggeredGridDelegate gridDelegate;

  @override
  ModRenderSliverStaggeredGrid createRenderObject(BuildContext context) {
    final element = context as ModSliverVariableSizeBoxAdaptorElement;
    return ModRenderSliverStaggeredGrid(childManager: element, gridDelegate: gridDelegate);
  }

  @override
  void updateRenderObject(BuildContext context, ModRenderSliverStaggeredGrid renderObject) {
    renderObject.gridDelegate = gridDelegate;
  }
}
