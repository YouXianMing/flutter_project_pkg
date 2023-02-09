import 'package:flutter/material.dart';

abstract class BaseScrollConfig {
  /// (abstract) 是否使用没有阴影的设置
  bool get useNoShadowScrollConfiguration;
  set useNoShadowScrollConfiguration(bool val);

  /// (abstract) 是否使用Scrollbar
  bool get useScrollbar;
  set useScrollbar(bool val);

  /// (abstract) 滑动控制器
  ScrollController? get controller;
  set controller(ScrollController? val);

  /// 构建widget
  Widget widgetAccess({required Widget child});
}
