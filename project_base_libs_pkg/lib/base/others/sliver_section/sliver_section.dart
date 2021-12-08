import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'base_sliver_section.dart';

enum SliverChildDelegateType {
  static, // 使用children模式
  builder, // 使用builder模式
}

/// [基类] SliverSection
abstract class SliverSection extends BaseSliverSection {
  /// (abstract) header控件的数据,如果设置了,则会在headerBuilder中传到里面去
  dynamic get headerData;
  set headerData(dynamic val);

  /// (abstract) header控件,如果设置了header,则Sliver会被SliverStickyHeader包裹
  Widget Function(dynamic)? get headerBuilder;
  set headerBuilder(Widget Function(dynamic)? val);

  /// (abstract) header是否悬停
  bool? get headerSticky;
  set headerSticky(bool? val);

  /// (abstract) SliverStickyHeader的控制器
  StickyHeaderController? get stickyHeaderController;
  set stickyHeaderController(StickyHeaderController? val);

  /// (abstract) 如果没有数据则不添加头部
  bool? get removeHeaderIfHaveNoData;
  set removeHeaderIfHaveNoData(bool? val);

  /// (abstract) 空数据则转换成BoxAdapter
  bool? get transformToBoxAdapterIfHaveNoData;
  set transformToBoxAdapterIfHaveNoData(bool? val);

  /// (abstract) 设置透明度
  double? get opacity;
  set opacity(double? val);

  /// (abstract) 设置padding,如果设置了padding,则Sliver会被SliverPadding包裹
  EdgeInsetsGeometry? get padding;
  set padding(EdgeInsetsGeometry? val);

  /// 根据需要对widget进行加工转换
  Widget processingBuildWidget(Widget widget) => widget;
}

/// [基类mixin] 提供给SliverList以及SliverGrid使用
mixin SliverSectionListItemsMixin {
  /// (abstract) 数据源(SliverChildDelegate的构建类型为builder时需要items)
  List<dynamic>? get items;
  set items(List<dynamic>? val);

  /// (abstract) 子控件(SliverChildDelegate的构建类型为static时需要children)
  List<Widget>? get children;
  set children(List<Widget>? val);

  /// (abstract) SliverChildDelegate的构建类型,默认为builder模式
  SliverChildDelegateType get sliverChildDelegateType;
  set sliverChildDelegateType(SliverChildDelegateType val);

  /// (abstract) builder
  SliverSectionListItemBuilder? get builder;
  set builder(SliverSectionListItemBuilder? val);

  /// 子控件是否为空
  bool get widgetListIsEmpty {
    bool itemsIsEmpty = false;
    if (sliverChildDelegateType == SliverChildDelegateType.builder) {
      itemsIsEmpty = items!.isEmpty;
    } else if (sliverChildDelegateType == SliverChildDelegateType.static) {
      itemsIsEmpty = children!.isEmpty;
    }
    return itemsIsEmpty;
  }

  /// 获取SliverChildDelegate
  SliverChildDelegate get sliverChildDelegate {
    SliverChildDelegate? delegate;
    if (sliverChildDelegateType == SliverChildDelegateType.builder) {
      delegate = SliverChildBuilderDelegate((context, index) => builder!(context, index, items![index]), childCount: items!.length);
    } else if (sliverChildDelegateType == SliverChildDelegateType.static) {
      delegate = SliverChildListDelegate(children!);
    }
    return delegate!;
  }
}
