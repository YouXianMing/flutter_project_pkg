import 'package:flutter/material.dart';

/// 用于自定义的StatefulWidget中的State,用来持有该State,可以更新组件用,一般用于controller中
mixin CustomStatefulWidgetStateMixin<T extends StatefulWidget> on State<T> {
  /// (abstract) 更新组件
  void stateMixinSetState();

  /// (abstract) 组件是否被挂载
  bool get stateMixinIsMounted;

  /// (abstract) 获取State的BuildContext
  BuildContext get stateMixinBuildContext;
}
