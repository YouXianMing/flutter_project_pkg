import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../indicator_widget.dart';

// 对开源库loading_animation_widget的简易封装,名字WateryDesert取其GitHub的人名
// https://pub.dev/packages/loading_animation_widget

enum WateryDesertIndicatorType {
  fallingDot,
  fourRotatingDots,
  prograssiveDots,
  discreteCircle, // color, secondColor, thirdColor
  threeArchedCircle,
  bouncingBall,
  flickr, // color, secondColor
  hexagonDots,
  beat,
  dotsTriangle,
  halfTriangleDot,
  twoRotatingArc,
  horizontalRotatingDots,
  newtonCradle,
  inkDrop,
  twistingDots, // color, secondColor
  staggeredDotsWave,
  stretchedDots,
  waveDots,
  threeRotatingDots,
}

class WateryDesertIndicatorConfig extends BaseIndicatorConfig {
  final Key? key;

  /// Indicate which type.
  final WateryDesertIndicatorType indicatorType;

  final double size;

  final Color color;

  final Color secondColor;

  final Color thirdColor;

  WateryDesertIndicatorConfig({
    required this.indicatorType,
    required this.size,
    required this.color,
    this.secondColor = Colors.red,
    this.thirdColor = Colors.yellow,
    this.key,
  });

  @override
  Widget get indicator {
    switch (indicatorType) {
      case WateryDesertIndicatorType.fallingDot:
        return LoadingAnimationWidget.fallingDot(key: key, color: color, size: size);
      case WateryDesertIndicatorType.fourRotatingDots:
        return LoadingAnimationWidget.fourRotatingDots(key: key, color: color, size: size);
      case WateryDesertIndicatorType.prograssiveDots:
        return LoadingAnimationWidget.prograssiveDots(key: key, color: color, size: size);
      case WateryDesertIndicatorType.discreteCircle:
        return LoadingAnimationWidget.discreteCircle(
            key: key, color: color, secondRingColor: secondColor, thirdRingColor: thirdColor, size: size);
      case WateryDesertIndicatorType.threeArchedCircle:
        return LoadingAnimationWidget.threeArchedCircle(key: key, color: color, size: size);
      case WateryDesertIndicatorType.bouncingBall:
        return LoadingAnimationWidget.bouncingBall(key: key, color: color, size: size);
      case WateryDesertIndicatorType.flickr:
        return LoadingAnimationWidget.flickr(key: key, leftDotColor: color, rightDotColor: secondColor, size: size);
      case WateryDesertIndicatorType.hexagonDots:
        return LoadingAnimationWidget.hexagonDots(key: key, color: color, size: size);
      case WateryDesertIndicatorType.beat:
        return LoadingAnimationWidget.beat(key: key, color: color, size: size);
      case WateryDesertIndicatorType.dotsTriangle:
        return LoadingAnimationWidget.dotsTriangle(key: key, color: color, size: size);
      case WateryDesertIndicatorType.halfTriangleDot:
        return LoadingAnimationWidget.halfTriangleDot(key: key, color: color, size: size);
      case WateryDesertIndicatorType.twoRotatingArc:
        return LoadingAnimationWidget.twoRotatingArc(key: key, color: color, size: size);
      case WateryDesertIndicatorType.horizontalRotatingDots:
        return LoadingAnimationWidget.horizontalRotatingDots(key: key, color: color, size: size);
      case WateryDesertIndicatorType.newtonCradle:
        return LoadingAnimationWidget.newtonCradle(key: key, color: color, size: size);
      case WateryDesertIndicatorType.inkDrop:
        return LoadingAnimationWidget.inkDrop(key: key, color: color, size: size);
      case WateryDesertIndicatorType.twistingDots:
        return LoadingAnimationWidget.twistingDots(key: key, leftDotColor: color, rightDotColor: secondColor, size: size);
      case WateryDesertIndicatorType.staggeredDotsWave:
        return LoadingAnimationWidget.staggeredDotsWave(key: key, color: color, size: size);
      case WateryDesertIndicatorType.stretchedDots:
        return LoadingAnimationWidget.stretchedDots(key: key, color: color, size: size);
      case WateryDesertIndicatorType.waveDots:
        return LoadingAnimationWidget.waveDots(key: key, color: color, size: size);
      case WateryDesertIndicatorType.threeRotatingDots:
        return LoadingAnimationWidget.threeRotatingDots(key: key, color: color, size: size);
    }
  }
}
