import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/others/scroll_config/scroll_config.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class SliverSectionsWidgetController {
  /// SliverSection相关对象的数组
  List<BaseSliverSection> sliverSections = [];

  /// 持有state
  CustomStatefulWidgetStateMixin? _stateMixin;

  /// 更新控件(更新数据源后调用此方法才可以更新数据)
  void updateWidget() {
    if (_stateMixin != null) _stateMixin!.stateMixinSetState();
  }
}

class SliverSectionsWidget extends StatefulWidget {
  /// 逻辑控制器
  final SliverSectionsWidgetController controller;

  /// scrollController
  final ScrollController? scrollController;

  /// 是否使用紧缩模式,默认为false
  final bool shrinkWrap;

  /// 缓存的距离
  final double? cacheExtent;

  /// 边缘裁剪方式,默认为Clip.hardEdge
  final Clip clipBehavior;

  /// 滑动方向,默认为垂直方向
  final Axis scrollDirection;

  /// 滑动的行为
  final ScrollBehavior? scrollBehavior;

  /// 滑动的模式
  final ScrollPhysics? physics;

  const SliverSectionsWidget({
    Key? key,
    required this.controller,
    this.scrollController,
    this.shrinkWrap = false,
    this.cacheExtent,
    this.clipBehavior = Clip.hardEdge,
    this.scrollDirection = Axis.vertical,
    this.scrollBehavior,
    this.physics,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SliverSectionsWidgetState();
}

class _SliverSectionsWidgetState extends State<SliverSectionsWidget> with CustomStatefulWidgetStateMixin {
  @override
  void initState() {
    super.initState();
    widget.controller._stateMixin = this;
  }

  @override
  void didUpdateWidget(covariant SliverSectionsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller._stateMixin = this;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller._stateMixin = this;
  }

  @override
  Widget build(BuildContext context) {
    // 直接设置ScrollController会导致CustomScrollView内容过少时无法滑动
    // https://stackoverflow.com/questions/65369458/customscrollview-scroll-behavior-changes-when-scrollcontroller-is-passed

    var scrollView = CustomScrollView(
      controller: widget.scrollController,
      shrinkWrap: widget.shrinkWrap,
      cacheExtent: widget.cacheExtent,
      clipBehavior: widget.clipBehavior,
      scrollDirection: widget.scrollDirection,
      scrollBehavior: widget.scrollBehavior,
      physics: widget.physics,
      slivers: widget.controller.sliverSections.buildAllSliverSectionsWidget(),
    );

    return CupertinoScrollConfig(controller: widget.scrollController).widgetAccess(child: scrollView);
  }

  // --- CustomStatefulWidgetMixin --- //

  @override
  void stateMixinSetState() {
    if (mounted) setState(() {});
  }

  @override
  bool get stateMixinIsMounted => mounted;

  @override
  BuildContext get stateMixinBuildContext => context;
}
