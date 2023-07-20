import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_scrolls_to_top.dart';

class SliverSectionsWidgetController {
  /// SliverSection相关对象的数组
  List<BaseSliverSection> sliverSections = [];

  /// 持有state
  CustomStatefulWidgetStateMixin? _stateMixin;

  /// 是否滑动到顶部配置
  OnScrollsToTopConfig? onScrollsToTopConfig;

  /// 设置OnScrollsToTopConfig
  SliverSectionsWidgetController setOnScrollsToTopConfig(OnScrollsToTopConfig? config) {
    onScrollsToTopConfig = config;
    return this;
  }

  /// ScrollView的key(有时候需要重设key来重构CustomScrollView)
  /// https://stackoverflow.com/questions/56364950/listview-doesnt-scroll-to-the-correct-offset-position-after-its-built-again
  Key? scrollViewKey;

  /// 更新控件(更新数据源后调用此方法才可以更新数据)
  void updateWidget() {
    if (_stateMixin != null) _stateMixin!.stateMixinSetState();
  }
}

class SliverSectionsWidget<ST extends BaseScrollStyleConfig> extends StatefulWidget {
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

  /// 键盘消失行为
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// 滑动风格配置
  final ST? scrollStyleConfig;

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
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.scrollStyleConfig,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SliverSectionsWidgetState();
}

class _SliverSectionsWidgetState extends State<SliverSectionsWidget> with CustomStatefulWidgetStateMixin, OnScrollsToTopConfigMixin {
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
      key: widget.controller.scrollViewKey,
      controller: widget.scrollController,
      shrinkWrap: widget.shrinkWrap,
      cacheExtent: widget.cacheExtent,
      clipBehavior: widget.clipBehavior,
      scrollDirection: widget.scrollDirection,
      scrollBehavior: widget.scrollBehavior,
      physics: widget.physics,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      slivers: widget.controller.sliverSections.buildAllSliverSectionsWidget(),
    );

    Widget tmpWidget = scrollView;

    if (widget.scrollStyleConfig != null) {
      widget.scrollStyleConfig!.controller = widget.scrollController;
      tmpWidget = widget.scrollStyleConfig!.widgetAccess(child: scrollView);
    }

    if (widget.controller.onScrollsToTopConfig != null) {
      tmpWidget = ScrollsToTop(onScrollsToTop: onScrollsToTopTapEvent, child: tmpWidget);
    }

    return tmpWidget;
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

  // --- OnScrollsToTopConfigMixin --- //

  @override
  OnScrollsToTopConfig? getOnScrollsToTopConfig() => widget.controller.onScrollsToTopConfig;

  @override
  ScrollController? getOnScrollsToTopScrollController() => widget.scrollController;
}
