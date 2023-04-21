import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWidget extends StatelessWidget {
  /// 数据
  final dynamic data;

  /// 构造器
  final Widget Function(dynamic) widgetBuilder;

  /// 用作Slidable的key,如果设置了该值,则直接将该值当做ValueKey使用.如果为空,则用data作为ValueKey使用.
  final dynamic slidableKeyValue;

  /// 分组的tag
  final Object? groupTag;

  /// 是否可以侧滑,默认为true
  final bool enabled;

  /// 是否滑动时收起,默认为true
  final bool closeOnScroll;

  /// 左侧的pane
  final ActionPane? startActionPane;

  /// 右侧的pane
  final ActionPane? endActionPane;

  /// 侧滑方向,默认为水平方向
  final Axis direction;

  /// DragStartBehavior
  final DragStartBehavior dragStartBehavior;

  /// 是否使用系统的对齐方式,默认为true
  final bool useTextDirection;

  const SlidableWidget({
    required this.data,
    required this.widgetBuilder,
    Key? key,
    this.slidableKeyValue,
    this.groupTag,
    this.enabled = true,
    this.closeOnScroll = true,
    this.direction = Axis.horizontal,
    this.startActionPane,
    this.endActionPane,
    this.dragStartBehavior = DragStartBehavior.down,
    this.useTextDirection = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: _getKey(),
      groupTag: groupTag,
      enabled: enabled,
      closeOnScroll: closeOnScroll,
      startActionPane: startActionPane,
      endActionPane: endActionPane,
      direction: direction,
      dragStartBehavior: dragStartBehavior,
      useTextDirection: useTextDirection,
      child: widgetBuilder(data),
    );
  }

  Key? _getKey() {
    ValueKey? valueKey;
    if (slidableKeyValue != null) {
      valueKey = ValueKey(slidableKeyValue);
    } else if (data != null) {
      valueKey = ValueKey(data);
    }

    return valueKey;
  }
}
