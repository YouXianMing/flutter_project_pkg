import 'package:flutter/material.dart';

class WidgetEventItem {
  /// 控件
  final Widget? widget;

  /// 标记
  final String? mark;

  /// 数据
  final dynamic data;

  /// 其他数据
  final dynamic extraData;
  const WidgetEventItem({this.widget, this.mark, this.data, this.extraData});
}

/// 控件事件的回调属性
typedef WidgetEventCallback = Function(BuildContext? context, WidgetEventItem eventItem);

mixin WidgetEventCallbackMixin {
  /// 控件事件的回调的方法
  void widgetEventCallback(BuildContext? context, WidgetEventItem eventItem);
}
