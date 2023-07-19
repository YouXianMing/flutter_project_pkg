import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/base_scroll_view_builder_config.dart';
import 'package:project_base_libs_pkg/base/typedef/project_typedef.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// 普通的ListViewBuilder
class ListViewBuilderConfig extends BaseScrollViewBuilderConfig {
  @override
  Key? builderKey;

  @override
  ItemWidgetBuilder builder;

  @override
  ScrollController? controller;

  @override
  List items;

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

  ListViewBuilderConfig({
    required this.items,
    required this.builder,
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
    return ListView.builder(
      key: builderKey,
      padding: padding,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      physics: physics,
      itemCount: items.length,
      scrollDirection: scrollDirection,
      controller: controller,
      keyboardDismissBehavior: keyboardDismissBehavior,
      itemBuilder: (c, i) => builder(c, i, items[i]),
    );
  }
}

/// 带有约束效果的ListViewBuilder,注意:shrinkWrap设置无效,始终为true
class ConstraintsListViewBuilderConfig extends BaseScrollViewBuilderConfig {
  @override
  Key? builderKey;

  @override
  ItemWidgetBuilder builder;

  @override
  ScrollController? controller;

  @override
  List items;

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

  final BoxConstraints constraints;

  ConstraintsListViewBuilderConfig({
    required this.items,
    required this.builder,
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
      child: ListView.builder(
        key: builderKey,
        padding: padding,
        shrinkWrap: true,
        reverse: reverse,
        physics: physics,
        itemCount: items.length,
        scrollDirection: scrollDirection,
        controller: controller,
        keyboardDismissBehavior: keyboardDismissBehavior,
        itemBuilder: (c, i) => builder(c, i, items[i]),
      ),
    );
  }
}

/// 可以滑动到具体index的ListViewBuilder
/// 注意: 该类的listView并没有复用功能,只能用于数量较小的list
class ScrollablePositionedListViewBuilderConfig extends BaseScrollViewBuilderConfig {
  @override
  Key? builderKey;

  @override
  ItemWidgetBuilder builder;

  @override
  ScrollController? controller;

  @override
  List items;

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
  ScrollablePositionedListViewBuilderConfig({
    required this.items,
    required this.builder,
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
      itemCount: items.length,
      scrollDirection: scrollDirection,
      itemBuilder: (c, i) => builder(c, i, items[i]),
      itemScrollController: itemScrollController,
      scrollOffsetController: scrollOffsetController,
      itemPositionsListener: itemPositionsListener,
      scrollOffsetListener: scrollOffsetListener,
      initialScrollIndex: initialScrollIndex,
      initialAlignment: initialAlignment,
    );
  }
}

/// 可以滑动到具体index的ListViewBuilder
/// 注意: 该类的listView并没有复用功能,只能用于数量较小的list
class ScrollToIndexListViewConfig extends BaseScrollViewBuilderConfig {
  @override
  Key? builderKey;

  @override
  ItemWidgetBuilder builder;

  @override
  ScrollController? controller;

  @override
  List items;

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

  /// 是否使用Builder模式,默认为true.如果为false,则builder中的context为空
  bool useBuilderMode;

  /// 可以滑动到具体index的ListViewBuilder
  /// 注意: 该类的listView并没有复用功能,只能用于数量较小的list
  ScrollToIndexListViewConfig({
    required this.items,
    required this.builder,
    required this.autoScrollController,
    this.useBuilderMode = true,
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
    if (useBuilderMode) {
      return ListView.builder(
        key: builderKey,
        padding: padding,
        shrinkWrap: shrinkWrap,
        reverse: reverse,
        physics: physics,
        itemCount: items.length,
        scrollDirection: scrollDirection,
        controller: autoScrollController,
        keyboardDismissBehavior: keyboardDismissBehavior,
        itemBuilder: (c, i) => AutoScrollTag(key: ValueKey(i), controller: autoScrollController, index: i, child: builder(c, i, items[i])),
      );
    } else {
      List<Widget> children = [];
      for (int i = 0; i < items.length; i++) {
        children.add(AutoScrollTag(key: ValueKey(i), controller: autoScrollController, index: i, child: builder(null, i, items[i])));
      }

      return ListView(
        key: builderKey,
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        scrollDirection: scrollDirection,
        controller: autoScrollController,
        keyboardDismissBehavior: keyboardDismissBehavior,
        children: children,
      );
    }
  }
}
