import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import '../indicator_widget.dart';

// 对开源库loading_indicator的简易封装,名字Cytryn取其GitHub的人名
// https://pub.flutter-io.cn/packages/loading_animations

enum CytrynIndicatorType {
  flippingCircle,
  flippingSquare,
  rotatingSquare,
  doubleFlippingCircle,
  doubleFlippingSquare,
  bouncingGridCircle,
  bouncingGridSquare,
  fillingSquare,
  fadingLineCircle,
  fadingLineSquare,
  bouncingLineCircle,
  bouncingLineSquare,
  jumpingLineCircle,
  jumpingLineSquare,
  bumpingLineCircle,
  bumpingLineSquare,
}

class CytrynIndicatorConfig extends BaseIndicatorConfig {
  final Key? key;

  /// Loading animation type.
  ///
  /// Default color is set to [Colors.blueGrey].
  final CytrynIndicatorType type;

  /// Sets an [AnimationController] is case you need to do something
  /// specific with it like play/pause animation.
  final AnimationController? controller;

  /// The color of the shape itself.
  ///
  /// Default color is set to [Colors.blueGrey].
  final Color backgroundColor;

  /// The color of the border of the shape.
  ///
  /// Default color is set to [Colors.transparent].
  final Color borderColor;

  /// Size of the whole square containing the animation.
  ///
  /// Default size is set to [50].
  final double size;

  /// Size of the border of the shape.
  ///
  /// Default size is set to [size/8].
  final double? borderSize;

  /// Total duration for one cycle of animation.
  ///
  /// Default value is set to [Duration(milliseconds: 1500)].
  final Duration? duration;

  /// Sets an [IndexedWidgetBuilder] function to return
  /// your own customized widget.
  final IndexedWidgetBuilder? itemBuilder;

  CytrynIndicatorConfig({
    required this.type,
    this.key,
    this.controller,
    this.backgroundColor = Colors.blueGrey,
    this.borderColor = Colors.transparent,
    this.size = 50,
    this.borderSize,
    this.duration,
    this.itemBuilder,
  });

  @override
  Widget get indicator {
    late Widget animationWidget;

    switch (type) {
      case CytrynIndicatorType.flippingCircle:
        animationWidget = LoadingFlipping.circle(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.flippingSquare:
        animationWidget = LoadingFlipping.square(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.rotatingSquare:
        animationWidget = LoadingRotating.square(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.doubleFlippingCircle:
        animationWidget = LoadingDoubleFlipping.circle(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.doubleFlippingSquare:
        animationWidget = LoadingDoubleFlipping.square(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.bouncingGridCircle:
        animationWidget = LoadingBouncingGrid.circle(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.bouncingGridSquare:
        animationWidget = LoadingBouncingGrid.square(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.fillingSquare:
        animationWidget = LoadingFilling.square(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 3000),
        );
        break;
      case CytrynIndicatorType.fadingLineCircle:
        animationWidget = LoadingFadingLine.circle(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.fadingLineSquare:
        animationWidget = LoadingFadingLine.square(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.bouncingLineCircle:
        animationWidget = LoadingBouncingLine.circle(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 3000),
        );
        break;
      case CytrynIndicatorType.bouncingLineSquare:
        animationWidget = LoadingBouncingLine.square(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 3000),
        );
        break;
      case CytrynIndicatorType.jumpingLineCircle:
        animationWidget = LoadingJumpingLine.circle(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.jumpingLineSquare:
        animationWidget = LoadingJumpingLine.square(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1500),
        );
        break;
      case CytrynIndicatorType.bumpingLineCircle:
        animationWidget = LoadingBumpingLine.circle(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 800),
        );
        break;
      case CytrynIndicatorType.bumpingLineSquare:
        animationWidget = LoadingBumpingLine.square(
          key: key,
          controller: controller,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          size: size,
          borderSize: borderSize,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 800),
        );
        break;
    }

    return animationWidget;
  }
}
