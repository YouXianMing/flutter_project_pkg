import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/others/no_shadow_scroll_behavior.dart';
import 'package:project_base_libs_pkg/base/others/scroll_config/base_scroll_style_config.dart';

/// iOS风格的滑动样式(在构造方法中设置controller需要注意代码实现)
class CupertinoScrollStyleConfig extends BaseScrollStyleConfig {
  @override
  ScrollController? controller;

  @override
  bool useNoShadowScrollConfiguration;

  @override
  bool useScrollbar;

  final bool? thumbVisibility;
  final double? thickness;
  final double? thicknessWhileDragging;
  final Radius? radius;
  final Radius? radiusWhileDragging;

  CupertinoScrollStyleConfig({
    this.controller,
    this.useNoShadowScrollConfiguration = false,
    this.useScrollbar = false,
    this.thumbVisibility,
    this.thickness,
    this.thicknessWhileDragging,
    this.radius,
    this.radiusWhileDragging,
  });

  @override
  Widget widgetAccess({required Widget child}) {
    Widget tmp = child;

    if (useScrollbar) {
      tmp = CupertinoScrollbar(
        controller: controller,
        thumbVisibility: thumbVisibility,
        thickness: thickness ?? CupertinoScrollbar.defaultThickness,
        thicknessWhileDragging: thicknessWhileDragging ?? CupertinoScrollbar.defaultThicknessWhileDragging,
        radius: radius ?? CupertinoScrollbar.defaultRadius,
        radiusWhileDragging: radiusWhileDragging ?? CupertinoScrollbar.defaultRadiusWhileDragging,
        child: tmp,
      );
    }

    if (useNoShadowScrollConfiguration) {
      tmp = noShadowScrollConfiguration(child: tmp);
    }

    return tmp;
  }
}

/// 安卓风格的滑动样式(在构造方法中设置controller需要注意代码实现)
class MaterialScrollStyleConfig extends BaseScrollStyleConfig {
  @override
  ScrollController? controller;

  @override
  bool useNoShadowScrollConfiguration;

  @override
  bool useScrollbar;

  final bool? thumbVisibility;
  final bool? trackVisibility;
  final double? thickness;
  final Radius? radius;
  final bool? interactive;

  MaterialScrollStyleConfig({
    this.controller,
    this.useNoShadowScrollConfiguration = false,
    this.useScrollbar = false,
    this.thumbVisibility,
    this.trackVisibility,
    this.thickness,
    this.radius,
    this.interactive,
  });

  @override
  Widget widgetAccess({required Widget child}) {
    Widget tmp = child;

    if (useScrollbar) {
      tmp = Scrollbar(
        controller: controller,
        thumbVisibility: thumbVisibility,
        trackVisibility: trackVisibility,
        thickness: thickness,
        radius: radius,
        interactive: interactive,
        child: tmp,
      );
    }

    if (useNoShadowScrollConfiguration) {
      tmp = noShadowScrollConfiguration(child: tmp);
    }

    return tmp;
  }
}
