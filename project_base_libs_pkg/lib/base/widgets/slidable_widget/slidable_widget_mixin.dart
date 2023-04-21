import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// 从context中获取SlidableController,需要被Slidable包裹的子类才能获取到SlidableController
SlidableController? getSlidableController(BuildContext context) => Slidable.of(context);

/// 无侵入方式改造widget支持侧滑效果
mixin SlidableWidgetMixin {
  /// (abstract) 构建SlidebleWidget需要的child
  Widget buildSlidableWidgetChild(BuildContext context);

  /// (abstract) 提供SlidebleWidget需要的key
  Key getSlidableValueKey();

  /// 提供左侧的pane
  ActionPane? createStartActionPane() => null;

  /// 提供右侧的pane
  ActionPane? createEndActionPane() => null;

  /// 设置是否使用SlidebleWidget,如果为true,则用Slidable包裹widget
  bool get setUseSlidableWidget => true;

  /// 设置是否激活Slidable,默认为true
  bool get setSlidableEnabled => true;

  /// 设置是否滑动收起pane,默认为true
  bool get setSlidableCloseOnScroll => true;

  /// 设置GroupTag,默认为空
  Object? setSlidableGroupTag() => null;

  /// 构建SlidebleWidget,用作Mixin的build方法
  Widget buildSlidableWidget(BuildContext context) {
    return setUseSlidableWidget
        ? Slidable(
            key: getSlidableValueKey(),
            groupTag: setSlidableGroupTag(),
            enabled: setSlidableEnabled,
            closeOnScroll: setSlidableCloseOnScroll,
            startActionPane: createStartActionPane(),
            endActionPane: createEndActionPane(),
            child: buildSlidableWidgetChild(context),
          )
        : buildSlidableWidgetChild(context);
  }
}
