import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import '../base_sliver_section.dart';
import '../sliver_section.dart';

/// SliverWrapSection
class SliverWrapSection extends SliverSection {
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
  SliverSectionWrapItemBuilder? builder;

  /// 数据数组
  List<dynamic>? items;

  /// 子控件水平方向间距,默认为0
  double spacing;

  /// 垂直方向间距,默认为0
  double runSpacing;

  Axis direction;

  WrapAlignment alignment;

  WrapAlignment runAlignment;

  WrapCrossAlignment crossAxisAlignment;

  TextDirection? textDirection;

  VerticalDirection verticalDirection;

  Clip clipBehavior;

  /// 背景色
  Color? backgroundColor;

  SliverWrapSection({
    this.mark,
    this.headerData,
    this.headerBuilder,
    this.headerSticky = true,
    this.stickyHeaderController,
    this.removeHeaderIfHaveNoData = true,
    this.transformToBoxAdapterIfHaveNoData = true,
    this.padding,
    this.builder,
    this.items,
    this.spacing = 0,
    this.runSpacing = 0,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    this.textDirection,
    this.backgroundColor,
    this.opacity,
  });

  static Widget widget({
    required SliverSectionWrapItemBuilder builder,
    required List<dynamic> items,
    String? mark,
    dynamic headerData,
    SliverSectionHeaderBuilder? headerBuilder,
    bool? headerSticky,
    StickyHeaderController? stickyHeaderController,
    bool? removeHeaderIfHaveNoData,
    bool? transformToBoxAdapterIfHaveNoData,
    EdgeInsetsGeometry? padding,
    double spacing = 0,
    double runSpacing = 0,
    Axis direction = Axis.horizontal,
    WrapAlignment alignment = WrapAlignment.start,
    WrapAlignment runAlignment = WrapAlignment.start,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    Clip clipBehavior = Clip.none,
    Color? backgroundColor,
    double? opacity,
  }) {
    return SliverWrapSection(
      mark: mark,
      headerData: headerData,
      headerBuilder: headerBuilder,
      headerSticky: headerSticky,
      stickyHeaderController: stickyHeaderController,
      removeHeaderIfHaveNoData: removeHeaderIfHaveNoData,
      transformToBoxAdapterIfHaveNoData: transformToBoxAdapterIfHaveNoData,
      items: items,
      padding: padding,
      builder: builder,
      backgroundColor: backgroundColor,
      spacing: spacing,
      runSpacing: runSpacing,
      direction: direction,
      alignment: alignment,
      runAlignment: runAlignment,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
      opacity: opacity,
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
    assert(builder != null);
    assert(items != null);

    if (transformToBoxAdapterIfHaveNoData == true && items!.isEmpty) {
      return processingBuildWidget(const SliverToBoxAdapter(child: SizedBox()));
    }

    List<Widget> widgets = [];
    for (int i = 0; i < items!.length; i++) {
      widgets.add(builder!(i, items![i]));
    }

    return processingBuildWidget(
      SliverToBoxAdapter(
        child: Container(
          padding: padding,
          color: backgroundColor,
          child: Wrap(
            direction: direction,
            alignment: alignment,
            spacing: spacing,
            runAlignment: runAlignment,
            runSpacing: runSpacing,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            clipBehavior: clipBehavior,
            children: widgets,
          ),
        ),
      ),
    );
  }

  @override
  Widget processingBuildWidget(Widget widget) {
    /// 根据需要构建SliverStickyHeader
    if (removeHeaderIfHaveNoData == true && items!.isEmpty) {
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

    /// 如果设置了透明度,则构建SliverOpacity
    if (opacity != null) widget = SliverOpacity(opacity: opacity!, sliver: widget);

    return widget;
  }
}
