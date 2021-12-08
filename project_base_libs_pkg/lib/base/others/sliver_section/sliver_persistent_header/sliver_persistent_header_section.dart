import 'package:flutter/material.dart';
import '../base_sliver_section.dart';

/// SliverPersistentHeaderSection
class SliverPersistentHeaderSection extends BaseSliverSection {
  @override
  String? mark;

  /// 最大高度
  double? maxExtent;

  /// 最小高度
  double? minExtent;

  /// 是否浮动
  bool floating;

  /// 是否悬停
  bool pinned;

  /// 是否实时重建
  bool shouldRebuild;

  /// 数据
  dynamic data;

  /// builder
  SliverSectionPersistentHeaderBuilder? builder;

  SliverPersistentHeaderSection({
    this.mark,
    this.maxExtent,
    this.minExtent,
    this.builder,
    this.floating = false,
    this.pinned = false,
    this.shouldRebuild = true,
    this.data,
  });

  static Widget widget({
    String? mark,
    required double maxExtent,
    required double minExtent,
    required SliverSectionPersistentHeaderBuilder builder,
    bool floating = false,
    bool pinned = false,
    bool shouldRebuild = true,
    dynamic data,
  }) {
    return SliverPersistentHeaderSection(
      mark: mark,
      maxExtent: maxExtent,
      minExtent: minExtent,
      builder: builder,
      floating: floating,
      pinned: pinned,
      shouldRebuild: shouldRebuild,
      data: data,
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
    assert(maxExtent != null);
    assert(minExtent != null);
    assert(builder != null);
    return SliverPersistentHeader(
      delegate: SliverPersistentHeaderSectionDelegate(
        maxExtentValue: maxExtent!,
        minExtentValue: minExtent!,
        data: data,
        widgetBuilder: builder!,
        shouldRebuildValue: shouldRebuild,
      ),
      floating: floating,
      pinned: pinned,
    );
  }
}

class SliverPersistentHeaderSectionDelegate extends SliverPersistentHeaderDelegate {
  double maxExtentValue;
  double minExtentValue;
  dynamic data;
  Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent, dynamic data) widgetBuilder;
  bool shouldRebuildValue;

  SliverPersistentHeaderSectionDelegate({
    required this.maxExtentValue,
    required this.minExtentValue,
    required this.widgetBuilder,
    required this.shouldRebuildValue,
    this.data,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => widgetBuilder(context, shrinkOffset, overlapsContent, data);

  @override
  double get maxExtent => maxExtentValue;

  @override
  double get minExtent => minExtentValue;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => shouldRebuildValue;
}
