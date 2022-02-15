import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef SliverSectionHeaderBuilder = Widget Function(dynamic);
typedef SliverSectionWrapItemBuilder = Widget Function(int index, dynamic data);
typedef SliverSectionListItemBuilder = Widget Function(BuildContext context, int index, dynamic data);
typedef SliverSectionLayoutBuilder = Widget Function(BuildContext context, SliverConstraints constraints, dynamic data);
typedef SliverSectionPersistentHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent, dynamic data);

/// [基类] BaseSliverSection
abstract class BaseSliverSection {
  /// (abstract) 标记
  String? get mark;
  set mark(String? val);

  /// (abstract) 构建widget
  Widget buildWidget();
}

/// SliverSection的数组的操作
extension SliverSectionList<T extends BaseSliverSection> on List<T> {
  /// 将所有的SliverSection的Widget构建出来
  List<Widget> buildAllSliverSectionsWidget() {
    List<Widget> list = [];
    for (dynamic element in this) {
      list.add(element.buildWidget());
    }
    return list;
  }

  /// 根据mark找到第一个出现的SliverSection
  BaseSliverSection? sliverSectionByMark(String mark) {
    BaseSliverSection? section;
    for (int i = 0; i < length; i++) {
      if (this[i].mark != null && this[i].mark == mark) {
        section = this[i];
        break;
      }
    }
    return section;
  }
}
