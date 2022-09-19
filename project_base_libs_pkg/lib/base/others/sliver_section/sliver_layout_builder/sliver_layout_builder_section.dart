import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/base_sliver_section.dart';

/// SliverLayoutBuilderSection
class SliverLayoutBuilderSection extends BaseSliverSection {
  @override
  String? mark;

  /// 数据
  dynamic data;

  /// builder
  /// 注意:构建出来的widget必须是Sliver家族的控件
  SliverSectionLayoutBuilder? builder;

  /// 控件在CustomScrollView上的位置
  double _precedingScrollExtent = 0;
  double get precedingScrollExtent => _precedingScrollExtent;

  SliverLayoutBuilderSection({
    this.mark,
    this.builder,
    this.data,
  });

  static Widget widget({
    required SliverSectionLayoutBuilder builder,
    String? mark,
    dynamic data,
  }) {
    return SliverLayoutBuilderSection(
      mark: mark,
      builder: builder,
      data: data,
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
    assert(builder != null);
    return SliverLayoutBuilder(builder: (BuildContext context, SliverConstraints constraints) {
      _precedingScrollExtent = constraints.precedingScrollExtent;
      return builder!(context, constraints, data);
    });
  }
}
