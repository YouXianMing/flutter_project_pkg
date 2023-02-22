import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/base_scroll_view_builder_config.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/widgets_factory.dart';

/// 普通的GridViewBuilder
class GridViewBuilderConfig extends BaseScrollViewBuilderConfig {
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

  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  GridViewBuilderConfig({
    required this.items,
    required this.builder,
    this.builderKey,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.crossAxisCount = 1,
    this.childAspectRatio = 1,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.shrinkWrap = false,
    this.physics,
    this.padding = EdgeInsets.zero,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build() {
    return GridView.builder(
      key: builderKey,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: items.length,
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
      itemBuilder: (c, i) => builder(c, i, items[i]),
    );
  }
}

/// 带有约束效果的GridViewBuilder,注意:shrinkWrap设置无效,始终为true
class ConstraintsGridViewBuilderConfig extends BaseScrollViewBuilderConfig {
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

  final BoxConstraints constraints;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  ConstraintsGridViewBuilderConfig({
    required this.items,
    required this.builder,
    required this.constraints,
    this.builderKey,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.crossAxisCount = 1,
    this.childAspectRatio = 1,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.shrinkWrap = false,
    this.physics,
    this.padding = EdgeInsets.zero,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build() {
    return Container(
      constraints: constraints,
      child: GridView.builder(
        key: builderKey,
        shrinkWrap: true,
        physics: physics,
        itemCount: items.length,
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
        itemBuilder: (c, i) => builder(c, i, items[i]),
      ),
    );
  }
}
