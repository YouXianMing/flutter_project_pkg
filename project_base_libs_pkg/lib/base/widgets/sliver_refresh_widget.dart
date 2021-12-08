import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../base_file_headers.dart';
import '../others/sliver_section/base_sliver_section.dart';

typedef SliversRefreshWidgetBlock = Function(SliversRefreshWidget widget);
typedef SliversRefreshWidgetHeaderFooterBuilder = Widget Function(bool);

class _SliversRefreshWidgetController extends GetxController {
  RxInt reloadData = 0.obs;
  late bool pullRefreshEnable;
  late bool loadMoreEnable;
  late List<SliverSection> sliverSections = [];
  late bool refreshHeaderWidgetAddSafeTop;
  late bool loadMoreFooterWidgetAddSafeBottom;
  SliversRefreshWidgetBlock? onRefreshBlock;
  SliversRefreshWidgetBlock? onLoadBlock;
  SliversRefreshWidgetHeaderFooterBuilder? headerBuilder;
  SliversRefreshWidgetHeaderFooterBuilder? footerBuilder;
  void updateWidget() => reloadData.value++;

  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();
}

class SliversRefreshWidget extends StatelessWidget {
  final _SliversRefreshWidgetController _controller = _SliversRefreshWidgetController();

  SliversRefreshWidget({
    Key? key,
    bool pullRefreshEnable = true,
    bool loadMoreEnable = true,
    List<SliverSection> sliverSections = const [],
    bool refreshHeaderWidgetAddSafeTop = false,
    bool loadMoreFooterWidgetAddSafeBottom = false,
    SliversRefreshWidgetBlock? onRefreshBlock,
    SliversRefreshWidgetBlock? onLoadBlock,
    SliversRefreshWidgetHeaderFooterBuilder? headerBuilder,
    SliversRefreshWidgetHeaderFooterBuilder? footerBuilder,
  }) : super(key: key) {
    _controller.pullRefreshEnable = pullRefreshEnable;
    _controller.loadMoreEnable = loadMoreEnable;
    _controller.sliverSections.addAll(sliverSections);
    _controller.refreshHeaderWidgetAddSafeTop = refreshHeaderWidgetAddSafeTop;
    _controller.loadMoreFooterWidgetAddSafeBottom = loadMoreFooterWidgetAddSafeBottom;
    _controller.onRefreshBlock = onRefreshBlock;
    _controller.onLoadBlock = onLoadBlock;
    _controller.headerBuilder = headerBuilder;
    _controller.footerBuilder = footerBuilder;
  }

  /// 获取下拉刷新是否开启了
  bool get isPullRefreshEnable => _controller.pullRefreshEnable;

  /// 设置下拉刷新,如果update为true,则控件立即重构
  SliversRefreshWidget setPullRefreshEnable(bool enable, {bool update = true}) {
    _controller.pullRefreshEnable = enable;
    if (update) _controller.updateWidget();
    return this;
  }

  /// 获取加载更多是否开启了
  bool get isLoadMoreEnable => _controller.loadMoreEnable;

  /// 设置加载更多,如果update为true,则控件立即重构
  SliversRefreshWidget setLoadMoreEnable(bool enable, {bool update = true}) {
    _controller.loadMoreEnable = enable;
    if (update) _controller.updateWidget();
    return this;
  }

  /// 刷新(重新构建SmartRefresher)
  SliversRefreshWidget update({SliversRefreshWidgetBlock? block, Function(bool?)? itemsDidFillRefreshWidget}) {
    _controller.updateWidget();
    if (block != null) block(this);

    if (itemsDidFillRefreshWidget != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_controller.refreshController.position != null) {
          itemsDidFillRefreshWidget(!(_controller.refreshController.position!.maxScrollExtent <= 0));
        } else {
          itemsDidFillRefreshWidget(null);
        }
      });
    }

    return this;
  }

  /// 设置下拉刷新的回调
  SliversRefreshWidget setOnRefreshBlock(SliversRefreshWidgetBlock? block) {
    _controller.onRefreshBlock = block;
    return this;
  }

  /// 设置加载更多的回调
  SliversRefreshWidget setOnLoadBlock(SliversRefreshWidgetBlock? block) {
    _controller.onLoadBlock = block;
    return this;
  }

  /// 手动调用刷新
  SliversRefreshWidget requestRefresh(
      {bool needMove = true, bool needCallback = true, Duration duration = const Duration(milliseconds: 500), Curve curve = Curves.linear}) {
    _controller.refreshController.requestRefresh(needMove: needMove, needCallback: needCallback, duration: duration, curve: curve);
    return this;
  }

  /// 手动调用加载更多
  SliversRefreshWidget requestLoading(
      {bool needMove = true, bool needCallback = true, Duration duration = const Duration(milliseconds: 300), Curve curve = Curves.linear}) {
    _controller.refreshController.requestLoading(needMove: needMove, needCallback: needCallback, duration: duration, curve: curve);
    return this;
  }

  /// 获取SliverSection的数组
  List<SliverSection> get sliversSections => _controller.sliverSections;

  /// 获取ScrollController的实例
  ScrollController get scrollController => _controller.scrollController;

  /// 结束刷新,如果update为true,则控件立即重构(请在处理完数据后再调用此方法)
  void endRefresh({bool resetLoadMore = true, bool failed = false, bool update = true}) {
    if (resetLoadMore == true) _controller.refreshController.loadComplete();

    if (failed == true) {
      _controller.refreshController.refreshFailed();
    } else {
      _controller.refreshController.refreshCompleted();
    }

    if (update == true) _controller.updateWidget();
  }

  /// 结束加载更多(请在处理完数据后再调用此方法)
  void endLoadData({bool noMoreData = false, bool failed = false, bool update = true}) {
    if (noMoreData == true && failed == true) {
      /// 如果noMoreData与failed同时为true,则failed优先级最高
      _controller.refreshController.loadFailed();
    } else if (noMoreData == true) {
      _controller.refreshController.loadNoData();
    } else if (failed == true) {
      _controller.refreshController.loadFailed();
    } else {
      _controller.refreshController.loadComplete();
    }

    if (update == true) _controller.updateWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.reloadData.value > 0) {}
      return SmartRefresher(
        controller: _controller.refreshController,
        enablePullDown: _controller.pullRefreshEnable,
        enablePullUp: _controller.loadMoreEnable,
        header: _controller.headerBuilder != null ? _controller.headerBuilder!(_controller.refreshHeaderWidgetAddSafeTop) : defaultHeader(context),
        footer:
        _controller.footerBuilder != null ? _controller.footerBuilder!(_controller.loadMoreFooterWidgetAddSafeBottom) : defaultFooter(context),
        onRefresh: () {
          if (_controller.onRefreshBlock != null) _controller.onRefreshBlock!(this);
        },
        onLoading: () {
          if (_controller.onLoadBlock != null) _controller.onLoadBlock!(this);
        },
        child: CustomScrollView(
          controller: _controller.scrollController,
          slivers: _controller.sliverSections.buildAllSliverSectionsWidget(),
        ),
      );
    });
  }

  Widget defaultHeader(BuildContext context) {
    double paddingTop = 0;
    double containerHeight = 55;
    if (_controller.refreshHeaderWidgetAddSafeTop == true) {
      paddingTop = MediaQuery.of(Get.context!).padding.top;
      if (paddingTop > 0) paddingTop -= 10;
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

  Widget defaultFooter(BuildContext context) {
    double paddingBottom = 0;
    double containerHeight = 55;
    if (_controller.loadMoreFooterWidgetAddSafeBottom == true) {
      paddingBottom = MediaQuery.of(Get.context!).padding.bottom;
      if (paddingBottom > 0) paddingBottom -= 10;
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
}
