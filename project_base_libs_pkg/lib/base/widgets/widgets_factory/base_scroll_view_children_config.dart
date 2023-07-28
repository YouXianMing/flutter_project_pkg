import 'package:flutter/material.dart';

abstract class BaseScrollViewChildrenConfig {
  /// builderKey
  Key? get builderKey;
  set builderKey(Key? key);

  /// children
  List<Widget> get children;
  set children(List<Widget> children);

  /// Padding
  EdgeInsets? get padding;
  set padding(EdgeInsets? padding);

  /// shrinkWrap为false会尽可能的填充满parent组件给的空间大小.而shrinkWrap为true则是只满足自身大小。
  bool get shrinkWrap;
  set shrinkWrap(bool shrinkWrap);

  /// 滑动方向
  Axis get scrollDirection;
  set scrollDirection(Axis scrollDirection);

  /// 控制器
  ScrollController? get controller;
  set controller(ScrollController? controller);

  /// 确定可滚动控件的物理特性
  ScrollPhysics? get physics;
  set physics(ScrollPhysics? physics);

  /// 键盘收起操作
  ScrollViewKeyboardDismissBehavior get keyboardDismissBehavior;
  set keyboardDismissBehavior(ScrollViewKeyboardDismissBehavior keyboardDismissBehavior);

  /// 列表颠倒
  bool get reverse;
  set reverse(bool reverse);

  /// 构建widget
  Widget build();
}
