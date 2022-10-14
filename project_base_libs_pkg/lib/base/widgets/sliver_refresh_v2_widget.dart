import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

/// 定义的刷新用事件回调
typedef SliverSectionsRefreshWidgetCallback = Function(SliverSectionsRefreshWidgetController refreshController);

/// 定义的RefreshWidgetHeaderFooter构造器
typedef SliverSectionsRefreshWidgetHeaderFooterBuilder = Widget Function(bool addSafePadding, double paddingOffset);

class SliverSectionsRefreshWidgetController {
  /// RefreshWidgetHeader构造器
  SliverSectionsRefreshWidgetHeaderFooterBuilder? headerBuilder;

  /// RefreshWidgetFooter构造器
  SliverSectionsRefreshWidgetHeaderFooterBuilder? footerBuilder;

  /// 刷新组件是否添加顶部安全距离(刷新控件与屏幕顶部对齐时,可能根据需要要增加额外的安全距离,比如iPhone的刘海屏)
  bool refreshHeaderWidgetAddSafeTop;

  /// 刷新组件顶部安全距离的偏移量,只有在[refreshHeaderWidgetAddSafeTop]为true时,并且确实存在safePadding时才生效
  late double safePaddingTopOffset;

  /// 加载更多组件是否添加底部安全距离(刷新控件与屏幕底部对齐时,可能根据需要要增加额外的安全距离,比如iPhoneX底部的黑条区域)
  bool loadMoreFooterWidgetAddSafeBottom;

  /// 加载更多组件底部安全距离的偏移量,只有在[loadMoreFooterWidgetAddSafeBottom]为true时,并且确实存在safePadding时才生效
  late double safePaddingBottomOffset;

  /// 下拉刷新是否开启
  bool _pullRefreshEnable = false;

  /// 获取下拉刷新是否开启了
  bool get isPullRefreshEnable => _pullRefreshEnable;

  /// 加载更多是否开启
  bool _loadMoreEnable = false;

  /// 获取加载更多是否开启了
  bool get isLoadMoreEnable => _loadMoreEnable;

  /// 刷新回调
  SliverSectionsRefreshWidgetCallback? _onRefreshCallback;

  /// 加载更多回调
  SliverSectionsRefreshWidgetCallback? _onLoadCallback;

  /// 刷新组件的控制器
  final RefreshController refreshController = RefreshController();

  /// ScrollView的控制器
  final ScrollController scrollController = ScrollController();

  /// 设置下拉刷新,如果update为true,则控件立即重构
  SliverSectionsRefreshWidgetController setPullRefreshEnable(bool enable, {bool update = true}) {
    _pullRefreshEnable = enable;
    if (update) updateWidget();
    return this;
  }

  /// 设置加载更多,如果update为true,则控件立即重构
  SliverSectionsRefreshWidgetController setLoadMoreEnable(bool enable, {bool update = true}) {
    _loadMoreEnable = enable;
    if (update) updateWidget();
    return this;
  }

  /// 设置下拉刷新的回调
  SliverSectionsRefreshWidgetController setPullRefreshCallback(SliverSectionsRefreshWidgetCallback? callback) {
    _onRefreshCallback = callback;
    return this;
  }

  /// 设置加载更多的回调
  SliverSectionsRefreshWidgetController setLoadMoreCallback(SliverSectionsRefreshWidgetCallback? callback) {
    _onLoadCallback = callback;
    return this;
  }

  /// 手动调用刷新
  SliverSectionsRefreshWidgetController requestRefresh(
      {bool needMove = true,
      bool needCallback = true,
      Duration duration = const Duration(milliseconds: 500),
      Curve curve = Curves.linear}) {
    refreshController.requestRefresh(needMove: needMove, needCallback: needCallback, duration: duration, curve: curve);
    return this;
  }

  /// 手动调用加载更多
  SliverSectionsRefreshWidgetController requestLoading(
      {bool needMove = true,
      bool needCallback = true,
      Duration duration = const Duration(milliseconds: 300),
      Curve curve = Curves.linear}) {
    refreshController.requestLoading(needMove: needMove, needCallback: needCallback, duration: duration, curve: curve);
    return this;
  }

  /// 结束刷新,如果update为true,则控件立即重构(请在处理完数据后再调用此方法)
  void endRefresh({bool resetLoadMore = true, bool failed = false, bool update = true}) {
    if (resetLoadMore == true) refreshController.loadComplete();

    if (failed == true) {
      refreshController.refreshFailed();
    } else {
      refreshController.refreshCompleted();
    }

    if (update == true) updateWidget();
  }

  /// 结束加载更多(请在处理完数据后再调用此方法)
  void endLoadData({bool noMoreData = false, bool failed = false, bool update = true}) {
    if (noMoreData == true && failed == true) {
      // 如果noMoreData与failed同时为true,则failed优先级最高
      refreshController.loadFailed();
    } else if (noMoreData == true) {
      refreshController.loadNoData();
    } else if (failed == true) {
      refreshController.loadFailed();
    } else {
      refreshController.loadComplete();
    }

    if (update == true) updateWidget();
  }

  /// SliverSection相关对象的数组
  List<BaseSliverSection> sliverSections = [];

  /// 清空数据
  void clearSections() => sliverSections.clear();

  /// 持有state
  CustomStatefulWidgetStateMixin? _stateMixin;

  /// 更新控件(更新数据源后调用此方法才可以更新数据)
  void updateWidget() {
    if (_stateMixin != null) _stateMixin!.stateMixinSetState();
  }

  SliverSectionsRefreshWidgetController({
    this.refreshHeaderWidgetAddSafeTop = false,
    this.loadMoreFooterWidgetAddSafeBottom = false,
    this.headerBuilder,
    this.footerBuilder,
    double? safePaddingTopOffset,
    double? safePaddingBottomOffset,
    bool pullRefreshEnable = true,
    bool loadMoreEnable = true,
    SliverSectionsRefreshWidgetCallback? onRefreshCallback,
    SliverSectionsRefreshWidgetCallback? onLoadCallback,
  }) {
    this.safePaddingTopOffset = (safePaddingTopOffset ?? (PlatFormInfo.isIOS ? 10 : 0));
    this.safePaddingBottomOffset = (safePaddingBottomOffset ?? (PlatFormInfo.isIOS ? 10 : 0));
    _pullRefreshEnable = pullRefreshEnable;
    _loadMoreEnable = loadMoreEnable;
    setPullRefreshCallback(onRefreshCallback);
    setLoadMoreCallback(onLoadCallback);
  }
}

class SliverSectionsRefreshWidget extends StatefulWidget {
  /// 逻辑控制器
  final SliverSectionsRefreshWidgetController controller;

  const SliverSectionsRefreshWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SliverSectionsRefreshWidgetState();
}

class _SliverSectionsRefreshWidgetState extends State<SliverSectionsRefreshWidget> with CustomStatefulWidgetStateMixin {
  @override
  void initState() {
    super.initState();
    widget.controller._stateMixin = this;
  }

  @override
  void didUpdateWidget(covariant SliverSectionsRefreshWidget oldWidget) {
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
    return SmartRefresher(
      controller: widget.controller.refreshController,
      enablePullDown: widget.controller._pullRefreshEnable,
      enablePullUp: widget.controller._loadMoreEnable,
      header: widget.controller.headerBuilder != null
          ? widget.controller.headerBuilder!(widget.controller.refreshHeaderWidgetAddSafeTop, widget.controller.safePaddingTopOffset)
          : defaultHeader(context),
      footer: widget.controller.footerBuilder != null
          ? widget.controller.footerBuilder!(widget.controller.loadMoreFooterWidgetAddSafeBottom, widget.controller.safePaddingBottomOffset)
          : defaultFooter(context),
      onRefresh: () {
        if (widget.controller._onRefreshCallback != null) widget.controller._onRefreshCallback!(widget.controller);
      },
      onLoading: () {
        if (widget.controller._onLoadCallback != null) widget.controller._onLoadCallback!(widget.controller);
      },
      child: CustomScrollView(
        controller: widget.controller.scrollController,
        slivers: widget.controller.sliverSections.buildAllSliverSectionsWidget(),
      ),
    );
  }

  /// 默认的RefreshWidgetHeader
  Widget defaultHeader(BuildContext context) {
    double paddingTop = 0;
    double containerHeight = 55;
    if (widget.controller.refreshHeaderWidgetAddSafeTop == true) {
      // 读取当前屏幕的padding
      paddingTop = MediaQuery.of(context).padding.top;
      if (paddingTop > 0) {
        paddingTop -= widget.controller.safePaddingTopOffset;
        if (paddingTop <= 0) paddingTop = 0;
      }
    }

    return CustomHeader(
      height: paddingTop + containerHeight,
      builder: (BuildContext context, RefreshStatus? mode) {
        Widget body;
        if (mode == RefreshStatus.idle) {
          body = const Text('Pull down to refresh');
        } else if (mode == RefreshStatus.refreshing) {
          body = const CupertinoActivityIndicator();
        } else if (mode == RefreshStatus.failed) {
          body = const Text('Refresh failed!', style: TextStyle(color: Colors.red));
        } else if (mode == RefreshStatus.canRefresh) {
          body = const Text('Release to refresh');
        } else {
          body = const Text('Refresh success');
        }
        return Column(
          children: [Container(height: paddingTop), SizedBox(height: containerHeight, child: Center(child: body))],
        );
      },
    );
  }

  /// 默认的RefreshWidgetFooter
  Widget defaultFooter(BuildContext context) {
    double paddingBottom = 0;
    double containerHeight = 55;
    if (widget.controller.loadMoreFooterWidgetAddSafeBottom == true) {
      // 读取当前屏幕的padding
      paddingBottom = MediaQuery.of(context).padding.bottom;
      if (paddingBottom > 0) {
        paddingBottom -= widget.controller.safePaddingBottomOffset;
        if (paddingBottom <= 0) paddingBottom = 0;
      }
    }

    return CustomFooter(
      height: paddingBottom + containerHeight,
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const Text('Pull up load');
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = const Text('Load Failed! try again', style: TextStyle(color: Colors.red));
        } else if (mode == LoadStatus.canLoading) {
          body = const Text('Release to load more');
        } else {
          body = const Text('No more Data');
        }
        return Column(
          children: [SizedBox(height: containerHeight, child: Center(child: body)), Container(height: paddingBottom)],
        );
      },
    );
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
