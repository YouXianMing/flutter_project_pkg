import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../indicator_widget.dart';

// 对开源库loading_indicator的简易封装,名字TinoGuo取其GitHub的人名
// https://pub.dev/packages/loading_indicator

/// 34 different types animation enums.
enum TinoGuoIndicatorType {
  ballPulse,
  ballGridPulse,
  ballClipRotate,
  squareSpin,
  ballClipRotatePulse,
  ballClipRotateMultiple,
  ballPulseRise,
  ballRotate,
  cubeTransition,
  ballZigZag,
  ballZigZagDeflect,
  ballTrianglePath,
  ballTrianglePathColored,
  ballTrianglePathColoredFilled,
  ballScale,
  lineScale,
  lineScaleParty,
  ballScaleMultiple,
  ballPulseSync,
  ballBeat,
  lineScalePulseOut,
  lineScalePulseOutRapid,
  ballScaleRipple,
  ballScaleRippleMultiple,
  ballSpinFadeLoader,
  lineSpinFadeLoader,
  triangleSkewSpin,
  pacman,
  ballGridBeat,
  semiCircleSpin,
  ballRotateChase,
  orbit,
  audioEqualizer,
  circleStrokeSpin,
}

class TinoGuoIndicatorConfig extends BaseIndicatorConfig {
  final Key? key;

  /// Indicate which type.
  final TinoGuoIndicatorType indicatorType;

  /// The color you draw on the shape.
  final List<Color>? colors;
  final Color? backgroundColor;

  /// The stroke width of line.
  final double? strokeWidth;

  /// Applicable to which has cut edge of the shape
  final Color? pathBackgroundColor;

  TinoGuoIndicatorConfig({
    required this.indicatorType,
    this.key,
    this.colors,
    this.backgroundColor,
    this.strokeWidth,
    this.pathBackgroundColor,
  });

  @override
  Widget get indicator {
    late Indicator type;
    switch (indicatorType) {
      case TinoGuoIndicatorType.ballPulse:
        type = Indicator.ballPulse;
        break;
      case TinoGuoIndicatorType.ballGridPulse:
        type = Indicator.ballGridPulse;
        break;
      case TinoGuoIndicatorType.ballClipRotate:
        type = Indicator.ballClipRotate;
        break;
      case TinoGuoIndicatorType.squareSpin:
        type = Indicator.squareSpin;
        break;
      case TinoGuoIndicatorType.ballClipRotatePulse:
        type = Indicator.ballClipRotatePulse;
        break;
      case TinoGuoIndicatorType.ballClipRotateMultiple:
        type = Indicator.ballClipRotateMultiple;
        break;
      case TinoGuoIndicatorType.ballPulseRise:
        type = Indicator.ballPulseRise;
        break;
      case TinoGuoIndicatorType.ballRotate:
        type = Indicator.ballRotate;
        break;
      case TinoGuoIndicatorType.cubeTransition:
        type = Indicator.cubeTransition;
        break;
      case TinoGuoIndicatorType.ballZigZag:
        type = Indicator.ballZigZag;
        break;
      case TinoGuoIndicatorType.ballZigZagDeflect:
        type = Indicator.ballZigZagDeflect;
        break;
      case TinoGuoIndicatorType.ballTrianglePath:
        type = Indicator.ballTrianglePath;
        break;
      case TinoGuoIndicatorType.ballTrianglePathColored:
        type = Indicator.ballTrianglePathColored;
        break;
      case TinoGuoIndicatorType.ballTrianglePathColoredFilled:
        type = Indicator.ballTrianglePathColoredFilled;
        break;
      case TinoGuoIndicatorType.ballScale:
        type = Indicator.ballScale;
        break;
      case TinoGuoIndicatorType.lineScale:
        type = Indicator.lineScale;
        break;
      case TinoGuoIndicatorType.lineScaleParty:
        type = Indicator.lineScaleParty;
        break;
      case TinoGuoIndicatorType.ballScaleMultiple:
        type = Indicator.ballScaleMultiple;
        break;
      case TinoGuoIndicatorType.ballPulseSync:
        type = Indicator.ballPulseSync;
        break;
      case TinoGuoIndicatorType.ballBeat:
        type = Indicator.ballBeat;
        break;
      case TinoGuoIndicatorType.lineScalePulseOut:
        type = Indicator.lineScalePulseOut;
        break;
      case TinoGuoIndicatorType.lineScalePulseOutRapid:
        type = Indicator.lineScalePulseOutRapid;
        break;
      case TinoGuoIndicatorType.ballScaleRipple:
        type = Indicator.ballScaleRipple;
        break;
      case TinoGuoIndicatorType.ballScaleRippleMultiple:
        type = Indicator.ballScaleRippleMultiple;
        break;
      case TinoGuoIndicatorType.ballSpinFadeLoader:
        type = Indicator.ballSpinFadeLoader;
        break;
      case TinoGuoIndicatorType.lineSpinFadeLoader:
        type = Indicator.lineSpinFadeLoader;
        break;
      case TinoGuoIndicatorType.triangleSkewSpin:
        type = Indicator.triangleSkewSpin;
        break;
      case TinoGuoIndicatorType.pacman:
        type = Indicator.pacman;
        break;
      case TinoGuoIndicatorType.ballGridBeat:
        type = Indicator.ballGridBeat;
        break;
      case TinoGuoIndicatorType.semiCircleSpin:
        type = Indicator.semiCircleSpin;
        break;
      case TinoGuoIndicatorType.ballRotateChase:
        type = Indicator.ballRotateChase;
        break;
      case TinoGuoIndicatorType.orbit:
        type = Indicator.orbit;
        break;
      case TinoGuoIndicatorType.audioEqualizer:
        type = Indicator.audioEqualizer;
        break;
      case TinoGuoIndicatorType.circleStrokeSpin:
        type = Indicator.circleStrokeSpin;
        break;
    }

    return LoadingIndicator(
      key: key,
      indicatorType: type,
      colors: colors,
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth,
      pathBackgroundColor: pathBackgroundColor,
    );
  }
}
