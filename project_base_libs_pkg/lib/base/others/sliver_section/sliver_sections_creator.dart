import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/sliver_layout_builder/sliver_layout_builder_section.dart';
import 'package:project_base_libs_pkg/base/others/linear_equation.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/sliver_persistent_header/sliver_persistent_header_section.dart';

class SliverSectionCreator {
  /// 对SliverPersistentHeaderSection的简易封装
  static SliverLayoutBuilderSection persistentHeaderSection({
    required LinearEquation linearEquation,
    required double height1,
    required double height2,
    bool pinned = true,
    Widget Function()? widgetBuilder,
  }) {
    return SliverLayoutBuilderSection(
      builder: (context, constraints, data) {
        double max = constraints.viewportMainAxisExtent;
        linearEquation.startCalculateOnlyOnceWith(pointA: MATHPoint(x: max - height2, y: height1), pointB: MATHPoint(x: max, y: height2));
        double height = linearEquation.k * constraints.remainingPaintExtent + linearEquation.b;
        if (height < height1) {
          height = height1;
        } else if (height > height2) {
          height = height2;
        }
        return SliverPersistentHeaderSection.widget(
          maxExtent: height,
          minExtent: height,
          pinned: pinned,
          shouldRebuild: false,
          builder: (BuildContext context, double shrinkOffset, bool overlapsContent, dynamic data) {
            return widgetBuilder == null ? Container(color: Colors.transparent) : widgetBuilder();
          },
        );
      },
    );
  }
}
