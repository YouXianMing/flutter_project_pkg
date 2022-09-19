import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_base_libs_pkg/base/widgets/indicators/indicator_widget.dart';

// 对开源库flutter_spinkit的简易封装,名字取SpinKit
// https://pub.dev/packages/flutter_spinkit

enum SpinKitIndicatorType {
  rotatingPlain,
  doubleBounce,
  wave,
  wanderingCubes,
  fadingFour,
  fadingCube,
  pulse,
  chasingDots,
  threeBounce,
  circle,
  cubeGrid,
  fadingCircle,
  rotatingCircle,
  foldingCube,
  pumpingHeart,
  hourGlass,
  pouringHourGlass,
  pouringHourGlassRefined,
  fadingGrid,
  ring,
  ripple,
  spinningCircle,
  spinningLines,
  squareCircle,
  dualRing,
  pianoWave,
  dancingSquare,
  threeInOut,
}

class SpinKitIndicatorConfig extends BaseIndicatorConfig {
  final Key? key;
  final SpinKitIndicatorType type;
  final Color? color;
  final double? size;
  final Duration? duration;

  final IndexedWidgetBuilder? itemBuilder; // hourGlass,pouringHourGlass,pouringHourGlassRefined,ring,spinningLines,dualRing没有itemBuilder
  final AnimationController? controller; // wanderingCubes,chasingDots没有controller

  final int? itemCount; // wave,spinningLines,pianoWave专用
  final BoxShape? shape; // wanderingCubes,fadingFour,fadingGrid,spinningCircle专用
  final double? strokeWidth; // pouringHourGlass,pouringHourGlassRefined专用
  final double? lineWidth; // ring,spinningLines,dualRing专用

  final SpinKitWaveType? waveType; // wave专用
  final SpinKitPianoWaveType? pianoWaveType; // pianoWave专用
  final double? borderWidth; // ripple专用
  final Duration? delay; // threeInOut专用

  SpinKitIndicatorConfig({
    required this.type,
    this.key,
    this.color,
    this.size,
    this.itemBuilder,
    this.duration,
    this.controller,
    this.itemCount,
    this.waveType,
    this.shape,
    this.strokeWidth,
    this.lineWidth,
    this.borderWidth,
    this.pianoWaveType,
    this.delay,
  });

  @override
  Widget get indicator {
    switch (type) {
      case SpinKitIndicatorType.rotatingPlain:
        return SpinKitRotatingPlain(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.doubleBounce:
        return SpinKitDoubleBounce(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 2000),
          controller: controller,
        );
      case SpinKitIndicatorType.wave:
        return SpinKitWave(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
          itemCount: itemCount ?? 5,
          type: waveType ?? SpinKitWaveType.start,
        );
      case SpinKitIndicatorType.wanderingCubes:
        return SpinKitWanderingCubes(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1800),
          shape: shape ?? BoxShape.rectangle,
        );
      case SpinKitIndicatorType.fadingFour:
        return SpinKitFadingFour(
          key: key,
          color: color,
          size: size ?? 50,
          shape: shape ?? BoxShape.circle,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.fadingCube:
        return SpinKitFadingCube(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 2400),
          controller: controller,
        );
      case SpinKitIndicatorType.pulse:
        return SpinKitPulse(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(seconds: 1),
          controller: controller,
        );
      case SpinKitIndicatorType.chasingDots:
        return SpinKitChasingDots(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 2000),
        );
      case SpinKitIndicatorType.threeBounce:
        return SpinKitThreeBounce(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1400),
          controller: controller,
        );
      case SpinKitIndicatorType.circle:
        return SpinKitCircle(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.cubeGrid:
        return SpinKitCubeGrid(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.fadingCircle:
        return SpinKitFadingCircle(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.rotatingCircle:
        return SpinKitRotatingCircle(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.foldingCube:
        return SpinKitFoldingCube(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 2400),
          controller: controller,
        );
      case SpinKitIndicatorType.pumpingHeart:
        return SpinKitPumpingHeart(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 2400),
          controller: controller,
        );
      case SpinKitIndicatorType.hourGlass:
        return SpinKitHourGlass(
          key: key,
          color: color ?? Colors.red,
          size: size ?? 50,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.pouringHourGlass:
        return SpinKitPouringHourGlass(
          key: key,
          color: color ?? Colors.deepOrangeAccent,
          size: size ?? 50,
          strokeWidth: strokeWidth,
          duration: duration ?? const Duration(milliseconds: 2400),
          controller: controller,
        );
      case SpinKitIndicatorType.pouringHourGlassRefined:
        return SpinKitPouringHourGlassRefined(
          key: key,
          color: color ?? Colors.deepOrangeAccent,
          size: size ?? 50,
          strokeWidth: strokeWidth,
          duration: duration ?? const Duration(milliseconds: 2400),
          controller: controller,
        );
      case SpinKitIndicatorType.fadingGrid:
        return SpinKitFadingGrid(
          key: key,
          color: color,
          size: size ?? 50,
          shape: shape ?? BoxShape.circle,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.ring:
        return SpinKitRing(
          key: key,
          color: color ?? Colors.blueAccent,
          size: size ?? 50,
          lineWidth: lineWidth ?? 7,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.ripple:
        return SpinKitRipple(
          key: key,
          color: color,
          size: size ?? 50,
          borderWidth: borderWidth ?? 6,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1800),
          controller: controller,
        );
      case SpinKitIndicatorType.spinningCircle:
        return SpinKitSpinningCircle(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          shape: shape ?? BoxShape.circle,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.spinningLines:
        return SpinKitSpinningLines(
          key: key,
          color: color ?? Colors.black,
          size: size ?? 70,
          itemCount: itemCount ?? 5,
          lineWidth: lineWidth ?? 2,
          duration: duration ?? const Duration(milliseconds: 3000),
          controller: controller,
        );
      case SpinKitIndicatorType.squareCircle:
        return SpinKitSquareCircle(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 500),
          controller: controller,
        );
      case SpinKitIndicatorType.dualRing:
        return SpinKitDualRing(
          key: key,
          color: color ?? Colors.red,
          size: size ?? 50,
          lineWidth: lineWidth ?? 7,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.pianoWave:
        return SpinKitPianoWave(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          itemCount: itemCount ?? 5,
          type: pianoWaveType ?? SpinKitPianoWaveType.start,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.dancingSquare:
        return SpinKitDancingSquare(
          key: key,
          color: color,
          size: size ?? 60,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case SpinKitIndicatorType.threeInOut:
        return SpinKitThreeInOut(
          key: key,
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 500),
          delay: delay ?? const Duration(milliseconds: 50),
          controller: controller,
        );
    }
  }
}
