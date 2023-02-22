import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/base_scroll_view_builder_config.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/widgets_factory.dart';

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

  ListViewBuilderConfig({
    required this.items,
    required this.builder,
    this.builderKey,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.padding = EdgeInsets.zero,
    this.shrinkWrap = false,
    this.physics,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build() {
    return ListView.builder(
      key: builderKey,
      padding: padding,
      shrinkWrap: shrinkWrap,
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
