import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

enum LoadingAnimation {
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

class LoadingAnimationWidget extends StatelessWidget {
  /// Loading animation type.
  ///
  /// Default color is set to [Colors.blueGrey].
  final LoadingAnimation type;

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

  const LoadingAnimationWidget({
    Key? key,
    required this.type,
    this.controller,
    this.backgroundColor = Colors.blueGrey,
    this.borderColor = Colors.transparent,
    this.size = 50,
    this.borderSize,
    this.duration,
    this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget animationWidget;

    switch (type) {
      case LoadingAnimation.flippingCircle:
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
      case LoadingAnimation.flippingSquare:
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
      case LoadingAnimation.rotatingSquare:
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
      case LoadingAnimation.doubleFlippingCircle:
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
      case LoadingAnimation.doubleFlippingSquare:
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
      case LoadingAnimation.bouncingGridCircle:
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
      case LoadingAnimation.bouncingGridSquare:
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
      case LoadingAnimation.fillingSquare:
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
      case LoadingAnimation.fadingLineCircle:
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
      case LoadingAnimation.fadingLineSquare:
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
      case LoadingAnimation.bouncingLineCircle:
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
      case LoadingAnimation.bouncingLineSquare:
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
      case LoadingAnimation.jumpingLineCircle:
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
      case LoadingAnimation.jumpingLineSquare:
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
      case LoadingAnimation.bumpingLineCircle:
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
      case LoadingAnimation.bumpingLineSquare:
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
