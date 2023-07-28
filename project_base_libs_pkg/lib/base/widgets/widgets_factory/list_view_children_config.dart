import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/base_scroll_view_children_config.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ListViewChildrenConfig extends BaseScrollViewChildrenConfig {
  @override
  Key? builderKey;

  @override
  List<Widget> children;

  @override
  ScrollController? controller;

  @override
  ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  EdgeInsets? padding;

  @override
  ScrollPhysics? physics;

  @override
  bool reverse;

  @override
  Axis scrollDirection;

  @override
  bool shrinkWrap;

  ListViewChildrenConfig({
    required this.children,
    this.builderKey,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.padding = EdgeInsets.zero,
    this.shrinkWrap = false,
    this.reverse = false,
    this.physics,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build() {
    return ListView(
      key: builderKey,
      padding: padding,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      physics: physics,
      scrollDirection: scrollDirection,
      controller: controller,
      keyboardDismissBehavior: keyboardDismissBehavior,
      children: children,
    );
  }
}

/// 带有约束效果的ListView,注意:shrinkWrap设置无效,始终为true
class ConstraintsListViewChildrenConfig extends BaseScrollViewChildrenConfig {
  @override
  Key? builderKey;

  @override
  ScrollController? controller;

  @override
  List<Widget> children;

  @override
  ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  EdgeInsets? padding;

  @override
  ScrollPhysics? physics;

  @override
  Axis scrollDirection;

  /// 此参数无效,始终为true
  @override
  bool shrinkWrap;

  @override
  bool reverse;

  final BoxConstraints constraints;

  ConstraintsListViewChildrenConfig({
    required this.children,
    required this.constraints,
    this.builderKey,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.padding = EdgeInsets.zero,
    this.shrinkWrap = false,
    this.reverse = false,
    this.physics,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build() {
    return Container(
      constraints: constraints,
      child: ListView(
        key: builderKey,
        padding: padding,
        shrinkWrap: true,
        reverse: reverse,
        physics: physics,
        scrollDirection: scrollDirection,
        controller: controller,
        keyboardDismissBehavior: keyboardDismissBehavior,
        children: children,
      ),
    );
  }
}

/// 可以滑动到具体index的ListView
/// 注意: 该类的listView并没有复用功能,只能用于数量较小的list
class ScrollablePositionedListViewChildrenConfig extends BaseScrollViewChildrenConfig {
  @override
  Key? builderKey;

  /// 此参数无效
  @override
  ScrollController? controller;

  @override
  List<Widget> children;

  /// 此参数无效
  @override
  ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  EdgeInsets? padding;

  @override
  ScrollPhysics? physics;

  @override
  Axis scrollDirection;

  @override
  bool shrinkWrap;

  @override
  bool reverse;

  /// Controller for jumping or scrolling to an item.
  ItemScrollController? itemScrollController;

  /// Controller to scroll a certain number of pixels relative to the current scroll offset.
  /// Scrolls offset pixels relative to the current scroll offset. offset can be positive or negative.
  ScrollOffsetController? scrollOffsetController;

  /// Provides a listenable iterable of itemPositions of items that are on screen and their locations.
  ItemPositionsListener? itemPositionsListener;

  /// Create a ScrollablePositionedList whose items are provided by itemBuilder.
  ScrollOffsetListener? scrollOffsetListener;

  /// Index of an item to initially align within the viewport.
  int initialScrollIndex;

  /// Determines where the leading edge of the item at initialScrollIndex should be placed.
  /// See ItemScrollController.jumpTo for an explanation of alignment.
  double initialAlignment;

  /// 可以滑动到具体index的ListViewBuilder
  /// 注意: 该类的listView并没有复用功能,只能用于数量较小的list
  ScrollablePositionedListViewChildrenConfig({
    required this.children,
    this.builderKey,
    this.scrollDirection = Axis.vertical,
    this.padding = EdgeInsets.zero,
    this.shrinkWrap = false,
    this.reverse = false,
    this.physics,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.itemScrollController,
    this.scrollOffsetController,
    this.itemPositionsListener,
    this.scrollOffsetListener,
    this.initialScrollIndex = 0,
    this.initialAlignment = 0,
  });

  @override
  Widget build() {
    return ScrollablePositionedList.builder(
      key: builderKey,
      padding: padding,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      physics: physics,
      itemCount: children.length,
      scrollDirection: scrollDirection,
      itemBuilder: (c, i) => children[i],
      itemScrollController: itemScrollController,
      scrollOffsetController: scrollOffsetController,
      itemPositionsListener: itemPositionsListener,
      scrollOffsetListener: scrollOffsetListener,
      initialScrollIndex: initialScrollIndex,
      initialAlignment: initialAlignment,
    );
  }
}

/// 可以滑动到具体index的ListView
/// 注意: 该类的listView并没有复用功能,只能用于数量较小的list
class ScrollToIndexListViewChildrenConfig extends BaseScrollViewChildrenConfig {
  @override
  Key? builderKey;

  /// 此参数无效,已被AutoScrollController替换
  @override
  ScrollController? controller;

  @override
  List<Widget> children;

  @override
  ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  EdgeInsets? padding;

  @override
  ScrollPhysics? physics;

  @override
  Axis scrollDirection;

  @override
  bool shrinkWrap;

  @override
  bool reverse;

  /// 自动滑动控制器
  AutoScrollController autoScrollController;

  /// 可以滑动到具体index的ListViewBuilder
  /// 注意: 该类的listView并没有复用功能,只能用于数量较小的list
  ScrollToIndexListViewChildrenConfig({
    required this.children,
    required this.autoScrollController,
    this.builderKey,
    this.scrollDirection = Axis.vertical,
    this.padding = EdgeInsets.zero,
    this.shrinkWrap = false,
    this.reverse = false,
    this.physics,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build() {
    List<Widget> list = [];
    for (int i = 0; i < children.length; i++) {
      list.add(AutoScrollTag(key: ValueKey(i), controller: autoScrollController, index: i, child: children[i]));
    }

    return ListView(
      key: builderKey,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      scrollDirection: scrollDirection,
      controller: autoScrollController,
      keyboardDismissBehavior: keyboardDismissBehavior,
      reverse: reverse,
      children: list,
    );
  }
}
