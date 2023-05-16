import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/third_lib_scrolls_to_top.dart';

class OnScrollsToTopConfig {
  /// onScrollsToTop事件
  final Function(OnScrollsToTopConfigMixin obj, ScrollController? scrollController, OnScrollsToTopConfig? config) onScrollsToTopEvent;

  /// 是否自动滑动到顶部,默认值为true,是否有效由接收配置的类实现
  final bool autoScrollToTop;

  /// 自动滑动到顶部的时间
  final Duration scrollDuration;

  /// 自动滑动到顶部时的动画曲线
  final Curve curve;

  OnScrollsToTopConfig({
    required this.onScrollsToTopEvent,
    this.autoScrollToTop = true,
    this.scrollDuration = const Duration(milliseconds: 450),
    this.curve = Curves.ease,
  });
}

mixin OnScrollsToTopConfigMixin {
  /// 提供OnScrollsToTopConfig对象
  OnScrollsToTopConfig? getOnScrollsToTopConfig();

  /// 提供ScrollController对象
  ScrollController? getOnScrollsToTopScrollController();

  /// 滑动事件的实现,给scrolls_to_top使用的回调
  Future<void> onScrollsToTopTapEvent(ScrollsToTopEvent event) async {
    OnScrollsToTopConfig? config = getOnScrollsToTopConfig();
    ScrollController? scrollController = getOnScrollsToTopScrollController();

    if (config != null) {
      config.onScrollsToTopEvent(this, scrollController, config);

      if (config.autoScrollToTop == true && scrollController != null) {
        scrollController.animateTo(scrollController.position.minScrollExtent, duration: config.scrollDuration, curve: config.curve);
      }
    }
  }

  /// 滑动到顶部
  void onScrollsAnimateToTop({Duration? duration, Curve? curve}) {
    ScrollController? scrollController = getOnScrollsToTopScrollController();
    if (scrollController != null) {
      OnScrollsToTopConfig? config = getOnScrollsToTopConfig();
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: duration ?? config?.scrollDuration ?? const Duration(milliseconds: 450),
        curve: curve ?? config?.curve ?? Curves.ease,
      );
    }
  }
}
