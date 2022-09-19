import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/base_sliver_section.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/sliver_section.dart';

/// SliverFillRemainingSection
class SliverFillRemainingSection extends SliverSection {
  @override
  String? mark;

  @override
  dynamic headerData;

  @override
  SliverSectionHeaderBuilder? headerBuilder;

  @override
  bool? headerSticky;

  @override
  StickyHeaderController? stickyHeaderController;

  @override
  bool? removeHeaderIfHaveNoData;

  @override
  bool? transformToBoxAdapterIfHaveNoData;

  @override
  double? opacity;

  @override
  EdgeInsetsGeometry? padding;

  /// builder
  Widget Function(dynamic)? builder;

  /// 数据,可以为空
  dynamic data;

  /// 内容是否可以滚动,设置为false,向上滑动松手后,自动回到原位置,如果设置为true,向上滑动松手后,不会自动回到原位置,默认为true
  final bool hasScrollBody;

  /// 表示子控件是否应该应该伸展以填充超出区域(比如iOS的ListView默认可伸展出一部分区域),当hasScrollBody为false时才起作用,默认为false
  final bool fillOverscroll;

  SliverFillRemainingSection({
    this.mark,
    this.headerData,
    this.headerBuilder,
    this.headerSticky = true,
    this.stickyHeaderController,
    this.removeHeaderIfHaveNoData = true,
    this.transformToBoxAdapterIfHaveNoData = false,
    this.padding,
    this.builder,
    this.data,
    this.opacity,
    this.hasScrollBody = true,
    this.fillOverscroll = false,
  });

  static Widget widget({
    required Widget Function(dynamic) builder,
    String? mark,
    dynamic headerData,
    SliverSectionHeaderBuilder? headerBuilder,
    bool? headerSticky,
    StickyHeaderController? stickyHeaderController,
    bool? removeHeaderIfHaveNoData,
    bool? transformToBoxAdapterIfHaveNoData,
    EdgeInsetsGeometry? padding,
    dynamic data,
    double? opacity,
    bool hasScrollBody = true,
    bool fillOverscroll = false,
  }) {
    return SliverFillRemainingSection(
      mark: mark,
      headerData: headerData,
      headerBuilder: headerBuilder,
      headerSticky: headerSticky,
      stickyHeaderController: stickyHeaderController,
      removeHeaderIfHaveNoData: removeHeaderIfHaveNoData,
      transformToBoxAdapterIfHaveNoData: transformToBoxAdapterIfHaveNoData,
      padding: padding,
      builder: builder,
      data: data,
      opacity: opacity,
      hasScrollBody: hasScrollBody,
      fillOverscroll: fillOverscroll,
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
    assert(builder != null);

    if (transformToBoxAdapterIfHaveNoData == true && data == null) {
      return processingBuildWidget(const SliverToBoxAdapter(child: SizedBox()));
    }

    return processingBuildWidget(SliverFillRemaining(hasScrollBody: hasScrollBody, fillOverscroll: fillOverscroll, child: builder!(data)));
  }

  @override
  Widget processingBuildWidget(Widget widget) {
    // 根据需要构建SliverPadding
    if (padding != null) widget = SliverPadding(padding: padding!, sliver: widget);

    // 根据需要构建SliverStickyHeader
    if (removeHeaderIfHaveNoData == true && data == null) {
    } else {
      if (headerBuilder != null) {
        widget = SliverStickyHeader(
          header: headerBuilder!(headerData),
          sliver: widget,
          sticky: headerSticky ?? true,
          controller: stickyHeaderController,
        );
      }
    }

    // 如果设置了透明度,则构建SliverOpacity
    if (opacity != null) widget = SliverOpacity(opacity: opacity!, sliver: widget);

    return widget;
  }
}
