import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/custom_stateful_widget_mixin.dart';
import 'package:project_base_libs_pkg/base/widgets/widgets_factory/widgets_factory.dart';

/// 在需要设定某行不能拖动时,widget通过mixin来实现此功能禁用拖拽功能
mixin ReorderableListViewItemWidgetMixin {
  /// 是否可以拖拽
  bool canDrag();
}

/// 拖拽用控制器
class ReorderableListViewWidgetController {
  /// 持有state
  CustomStatefulWidgetStateMixin? _stateMixin;

  /// 子组件持有的数据
  List<dynamic> items = [];

  /// 更新items并刷新界面
  void update({List<dynamic>? items}) {
    // 如果设置了item,则更新item
    if (items != null) this.items = items;

    // 更新state
    if (_stateMixin != null) _stateMixin!.stateMixinSetState();
  }
}

/// 相关资料
/// http://www.laomengit.com/flutter/widgets/ReorderableListView.html
/// https://api.flutter.dev/flutter/widgets/ReorderableDelayedDragStartListener-class.html
/// https://api.flutter.dev/flutter/widgets/ReorderableDragStartListener-class.html
/// https://api.flutter.dev/flutter/widgets/SliverReorderableList-class.html
/// https://stackoverflow.com/questions/67665612/is-it-possible-to-disable-reordering-a-single-item-in-a-reorderable-listview-in
class ReorderableListViewWidget extends StatefulWidget {
  /// 逻辑控制器
  final ReorderableListViewWidgetController controller;

  /// Widge构造器
  final ItemWidgetBuilder builder;

  /// 是否可以拖拽(全局设置)
  final bool canDrag;

  /// 有延迟效果的拖拽,默认为true
  final bool useReorderableDelayedDragStartListener;

  final void Function(int index, dynamic data)? onReorderStart;
  final void Function(int index, dynamic data)? onReorderEnd;
  final void Function(int oldIndex, int newIndex)? onReorder;
  final EdgeInsets? padding;
  final Widget? header;
  final Widget? footer;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? scrollController;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const ReorderableListViewWidget({
    Key? key,
    required this.controller,
    required this.builder,
    this.canDrag = true,
    this.useReorderableDelayedDragStartListener = true,
    this.onReorderStart,
    this.onReorderEnd,
    this.onReorder,
    this.padding = EdgeInsets.zero,
    this.header,
    this.footer,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ReorderableListViewWidgetState();
}

class ReorderableListViewWidgetState extends State<ReorderableListViewWidget> with CustomStatefulWidgetStateMixin {
  @override
  void initState() {
    super.initState();
    widget.controller._stateMixin = this;
  }

  @override
  Widget build(BuildContext context) {
    // buildDefaultDragHandles为啥要设置成false
    // https://stackoverflow.com/questions/64409944/flutter-gesture-detector-in-reorderablelistview-not-working
    return ReorderableListView.builder(
      buildDefaultDragHandles: widget.useReorderableDelayedDragStartListener ? false : true,
      padding: widget.padding,
      header: widget.header,
      footer: widget.footer,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      scrollController: widget.scrollController,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (c, i) {
        var value = widget.controller.items[i];
        return _widgetBuildItem(data: value, child: widget.builder(context, i, value), index: i);
      },
      onReorderStart: (index) {
        if (widget.onReorderStart != null) widget.onReorderStart!(index, widget.controller.items[index]);
      },
      onReorderEnd: (index) {
        if (widget.onReorderEnd != null) widget.onReorderEnd!(index, widget.controller.items[index]);
      },
      itemCount: widget.controller.items.length,
      onReorder: (int oldIndex, int newIndex) {
        if (widget.onReorder != null) widget.onReorder!(oldIndex, newIndex);

        if (oldIndex < newIndex) newIndex -= 1;
        final element = widget.controller.items.removeAt(oldIndex);
        widget.controller.items.insert(newIndex, element);
        setState(() {});
      },
    );
  }

  Widget _widgetBuildItem({dynamic data, required Widget child, required int index}) {
    bool canDrag = true;
    if (child is ReorderableListViewItemWidgetMixin) canDrag = (child as ReorderableListViewItemWidgetMixin).canDrag();
    if (widget.canDrag == false) canDrag = false;

    return widget.useReorderableDelayedDragStartListener
        ? ReorderableDelayedDragStartListener(enabled: canDrag, key: ValueKey(data), index: index, child: child)
        : ReorderableDragStartListener(enabled: canDrag, key: ValueKey(data), index: index, child: child);
  }

  @override
  void didUpdateWidget(covariant ReorderableListViewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller._stateMixin = this;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller._stateMixin = this;
  }

  @override
  void stateMixinSetState() {
    if (mounted) setState(() {});
  }

  @override
  bool get stateMixinIsMounted => mounted;

  @override
  BuildContext get stateMixinBuildContext => context;
}
