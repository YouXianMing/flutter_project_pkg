import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/base_scroll_view_children_config.dart';

/// 普通的GridView
class GridViewChildrenConfig extends BaseScrollViewChildrenConfig {
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

  @override
  bool shrinkWrap;

  @override
  bool reverse;

  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  GridViewChildrenConfig({
    required this.children,
    this.builderKey,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.crossAxisCount = 1,
    this.childAspectRatio = 1,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.shrinkWrap = false,
    this.reverse = false,
    this.physics,
    this.padding = EdgeInsets.zero,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build() {
    return GridView(
      key: builderKey,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      physics: physics,
      padding: padding,
      scrollDirection: scrollDirection,
      controller: controller,
      keyboardDismissBehavior: keyboardDismissBehavior,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      ),
      children: children,
    );
  }
}

/// 带有约束效果的GridView,注意:shrinkWrap设置无效,始终为true
class ConstraintsGridViewChildrenConfig extends BaseScrollViewChildrenConfig {
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
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  ConstraintsGridViewChildrenConfig({
    required this.children,
    required this.constraints,
    this.builderKey,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.crossAxisCount = 1,
    this.childAspectRatio = 1,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.shrinkWrap = false,
    this.reverse = false,
    this.physics,
    this.padding = EdgeInsets.zero,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build() {
    return Container(
      constraints: constraints,
      child: GridView(
        key: builderKey,
        shrinkWrap: true,
        reverse: reverse,
        physics: physics,
        padding: padding,
        scrollDirection: scrollDirection,
        controller: controller,
        keyboardDismissBehavior: keyboardDismissBehavior,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
        ),
        children: children,
      ),
    );
  }
}
