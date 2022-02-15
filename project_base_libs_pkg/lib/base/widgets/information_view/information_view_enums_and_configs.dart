import 'package:flutter/material.dart';

/// InformationView状态值
enum InformationViewStatus {
  idle,
  show,
  hide,
}

/// AnimatedWidgetFactory需要的枚举值
enum AnimatedWidgetType {
  simpleToast, // 没有背景点击事件,只有简单的alpha动画效果
  popView, // 弹出框,有背景点击事件
  sheetView, // 弹出表单,有背景点击事件
}

/// InformationView显示的配置,是一个抽象类
abstract class BaseInformationViewConfig {}

/// AnimatedSheetView的配置

enum AnimatedSheetType {
  fromBottomToTop, // 从底部到顶部
  fromTopToBottom, // 从顶部到底部
  fromLeftToRight, // 从左到右
  fromRightToLeft, // 从右到左
}

class AnimatedSheetViewConfig extends BaseInformationViewConfig {
  final AnimatedSheetType type;
  final Duration showDuration;
  final Duration hideDuration;
  final Curve showCurve;
  final Curve hideCurve;
  final Color? backgroundColor;

  AnimatedSheetViewConfig({
    this.type = AnimatedSheetType.fromBottomToTop,
    this.showDuration = const Duration(milliseconds: 500),
    this.hideDuration = const Duration(milliseconds: 500),
    this.showCurve = Curves.easeOutQuint,
    this.hideCurve = Curves.easeInQuint,
    this.backgroundColor,
  });
}

/// AnimatedPopView的配置

class AnimatedPopViewConfig extends BaseInformationViewConfig {
  final double showScale;
  final double hideScale;
  final Duration showDuration;
  final Duration hideDuration;
  final Curve showCurve;
  final Curve hideCurve;
  final Color? backgroundColor;
  AnimatedPopViewConfig({
    this.showScale = 1.15,
    this.hideScale = 1.15,
    this.showDuration = const Duration(milliseconds: 250),
    this.hideDuration = const Duration(milliseconds: 250),
    this.showCurve = Curves.easeOutQuint,
    this.hideCurve = Curves.easeIn,
    this.backgroundColor,
  });
}
