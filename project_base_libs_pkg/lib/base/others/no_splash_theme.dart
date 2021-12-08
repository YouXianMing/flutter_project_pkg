import 'package:flutter/material.dart';

/// 用于MaterialApp中的theme上，禁用全局的点击波纹效果
ThemeData noSplashFactoryThemeData(BuildContext context) =>
    Theme.of(context).copyWith(highlightColor: Colors.transparent, splashFactory: const NoSplashFactory());

/// 用于普通控件上的无波纹的theme
Theme noSplashTheme({required Widget child}) =>
    Theme(data: ThemeData(splashFactory: const NoSplashFactory(), highlightColor: Colors.transparent), child: child);

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return NoSplash(controller: controller, referenceBox: referenceBox, color: color, onRemoved: onRemoved ?? () {});
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({required MaterialInkController controller, required RenderBox referenceBox, required Color color, VoidCallback? onRemoved})
      : super(controller: controller, referenceBox: referenceBox, onRemoved: onRemoved, color: color) {
    controller.addInkFeature(this);
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
