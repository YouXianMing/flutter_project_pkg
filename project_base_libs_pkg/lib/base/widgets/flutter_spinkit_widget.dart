import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum FlutterSpinKit {
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

class FlutterSpinKitWidget extends StatelessWidget {
  final FlutterSpinKit type;
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

  const FlutterSpinKitWidget({
    required this.type,
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case FlutterSpinKit.rotatingPlain:
        return SpinKitRotatingPlain(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.doubleBounce:
        return SpinKitDoubleBounce(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 2000),
          controller: controller,
        );
      case FlutterSpinKit.wave:
        return SpinKitWave(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
          itemCount: itemCount ?? 5,
          type: waveType ?? SpinKitWaveType.start,
        );
      case FlutterSpinKit.wanderingCubes:
        return SpinKitWanderingCubes(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1800),
          shape: shape ?? BoxShape.rectangle,
        );
      case FlutterSpinKit.fadingFour:
        return SpinKitFadingFour(
          color: color,
          size: size ?? 50,
          shape: shape ?? BoxShape.circle,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.fadingCube:
        return SpinKitFadingCube(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 2400),
          controller: controller,
        );
      case FlutterSpinKit.pulse:
        return SpinKitPulse(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(seconds: 1),
          controller: controller,
        );
      case FlutterSpinKit.chasingDots:
        return SpinKitChasingDots(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 2000),
        );
      case FlutterSpinKit.threeBounce:
        return SpinKitThreeBounce(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1400),
          controller: controller,
        );
      case FlutterSpinKit.circle:
        return SpinKitCircle(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.cubeGrid:
        return SpinKitCubeGrid(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.fadingCircle:
        return SpinKitFadingCircle(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.rotatingCircle:
        return SpinKitRotatingCircle(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.foldingCube:
        return SpinKitFoldingCube(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 2400),
          controller: controller,
        );
      case FlutterSpinKit.pumpingHeart:
        return SpinKitPumpingHeart(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 2400),
          controller: controller,
        );
      case FlutterSpinKit.hourGlass:
        return SpinKitHourGlass(
          color: color ?? Colors.red,
          size: size ?? 50,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.pouringHourGlass:
        return SpinKitPouringHourGlass(
          color: color ?? Colors.deepOrangeAccent,
          size: size ?? 50,
          strokeWidth: strokeWidth,
          duration: duration ?? const Duration(milliseconds: 2400),
          controller: controller,
        );
      case FlutterSpinKit.pouringHourGlassRefined:
        return SpinKitPouringHourGlassRefined(
          color: color ?? Colors.deepOrangeAccent,
          size: size ?? 50,
          strokeWidth: strokeWidth,
          duration: duration ?? const Duration(milliseconds: 2400),
          controller: controller,
        );
      case FlutterSpinKit.fadingGrid:
        return SpinKitFadingGrid(
          color: color,
          size: size ?? 50,
          shape: shape ?? BoxShape.circle,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.ring:
        return SpinKitRing(
          color: color ?? Colors.blueAccent,
          size: size ?? 50,
          lineWidth: lineWidth ?? 7,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.ripple:
        return SpinKitRipple(
          color: color,
          size: size ?? 50,
          borderWidth: borderWidth ?? 6,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1800),
          controller: controller,
        );
      case FlutterSpinKit.spinningCircle:
        return SpinKitSpinningCircle(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          shape: shape ?? BoxShape.circle,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.spinningLines:
        return SpinKitSpinningLines(
          color: color ?? Colors.black,
          size: size ?? 70,
          itemCount: itemCount ?? 5,
          lineWidth: lineWidth ?? 2,
          duration: duration ?? const Duration(milliseconds: 3000),
          controller: controller,
        );
      case FlutterSpinKit.squareCircle:
        return SpinKitSquareCircle(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 500),
          controller: controller,
        );
      case FlutterSpinKit.dualRing:
        return SpinKitDualRing(
          color: color ?? Colors.red,
          size: size ?? 50,
          lineWidth: lineWidth ?? 7,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.pianoWave:
        return SpinKitPianoWave(
          color: color,
          size: size ?? 50,
          itemBuilder: itemBuilder,
          itemCount: itemCount ?? 5,
          type: pianoWaveType ?? SpinKitPianoWaveType.start,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.dancingSquare:
        return SpinKitDancingSquare(
          color: color,
          size: size ?? 60,
          itemBuilder: itemBuilder,
          duration: duration ?? const Duration(milliseconds: 1200),
          controller: controller,
        );
      case FlutterSpinKit.threeInOut:
        return SpinKitThreeInOut(
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
