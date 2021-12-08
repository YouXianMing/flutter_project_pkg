import 'package:flutter/material.dart';

/// 封装了PageView与PageController,使使用更加方便
/// 使用PageView是为了让AutomaticKeepAliveClientMixin生效
class PageViewManager {
  /// 当前index
  int? _currentIndex;
  int? get index => _currentIndex;

  /// page控制器
  PageController? _controller;

  /// 构造方法
  PageViewManager({int currentIndex = 0}) {
    _currentIndex = currentIndex;
    _controller = PageController(initialPage: currentIndex);
  }

  /// PageView的builder
  PageView buildPageView({
    required IndexedWidgetBuilder itemBuilder,
    required int? itemCount,
    ScrollPhysics physics = const NeverScrollableScrollPhysics(),
  }) {
    return PageView.builder(itemBuilder: itemBuilder, controller: _controller, itemCount: itemCount, physics: physics);
  }

  /// 更新PageView选中的Widget
  void makeSelectIndex(int index) {
    _currentIndex = index;
    _controller!.jumpToPage(_currentIndex!);
  }
}
