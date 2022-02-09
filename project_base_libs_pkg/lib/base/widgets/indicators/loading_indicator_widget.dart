import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

/// 34 different types animation enums.
enum LoadingIndicatorType {
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

class LoadingIndicatorWidget extends StatelessWidget {
  /// Indicate which type.
  final LoadingIndicatorType indicatorType;

  /// The color you draw on the shape.
  final List<Color>? colors;
  final Color? backgroundColor;

  /// The stroke width of line.
  final double? strokeWidth;

  /// Applicable to which has cut edge of the shape
  final Color? pathBackgroundColor;

  const LoadingIndicatorWidget({
    Key? key,
    required this.indicatorType,
    this.colors,
    this.backgroundColor,
    this.strokeWidth,
    this.pathBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Indicator type;
    switch (indicatorType) {
      case LoadingIndicatorType.ballPulse:
        type = Indicator.ballPulse;
        break;
      case LoadingIndicatorType.ballGridPulse:
        type = Indicator.ballGridPulse;
        break;
      case LoadingIndicatorType.ballClipRotate:
        type = Indicator.ballClipRotate;
        break;
      case LoadingIndicatorType.squareSpin:
        type = Indicator.squareSpin;
        break;
      case LoadingIndicatorType.ballClipRotatePulse:
        type = Indicator.ballClipRotatePulse;
        break;
      case LoadingIndicatorType.ballClipRotateMultiple:
        type = Indicator.ballClipRotateMultiple;
        break;
      case LoadingIndicatorType.ballPulseRise:
        type = Indicator.ballPulseRise;
        break;
      case LoadingIndicatorType.ballRotate:
        type = Indicator.ballRotate;
        break;
      case LoadingIndicatorType.cubeTransition:
        type = Indicator.cubeTransition;
        break;
      case LoadingIndicatorType.ballZigZag:
        type = Indicator.ballZigZag;
        break;
      case LoadingIndicatorType.ballZigZagDeflect:
        type = Indicator.ballZigZagDeflect;
        break;
      case LoadingIndicatorType.ballTrianglePath:
        type = Indicator.ballTrianglePath;
        break;
      case LoadingIndicatorType.ballTrianglePathColored:
        type = Indicator.ballTrianglePathColored;
        break;
      case LoadingIndicatorType.ballTrianglePathColoredFilled:
        type = Indicator.ballTrianglePathColoredFilled;
        break;
      case LoadingIndicatorType.ballScale:
        type = Indicator.ballScale;
        break;
      case LoadingIndicatorType.lineScale:
        type = Indicator.lineScale;
        break;
      case LoadingIndicatorType.lineScaleParty:
        type = Indicator.lineScaleParty;
        break;
      case LoadingIndicatorType.ballScaleMultiple:
        type = Indicator.ballScaleMultiple;
        break;
      case LoadingIndicatorType.ballPulseSync:
        type = Indicator.ballPulseSync;
        break;
      case LoadingIndicatorType.ballBeat:
        type = Indicator.ballBeat;
        break;
      case LoadingIndicatorType.lineScalePulseOut:
        type = Indicator.lineScalePulseOut;
        break;
      case LoadingIndicatorType.lineScalePulseOutRapid:
        type = Indicator.lineScalePulseOutRapid;
        break;
      case LoadingIndicatorType.ballScaleRipple:
        type = Indicator.ballScaleRipple;
        break;
      case LoadingIndicatorType.ballScaleRippleMultiple:
        type = Indicator.ballScaleRippleMultiple;
        break;
      case LoadingIndicatorType.ballSpinFadeLoader:
        type = Indicator.ballSpinFadeLoader;
        break;
      case LoadingIndicatorType.lineSpinFadeLoader:
        type = Indicator.lineSpinFadeLoader;
        break;
      case LoadingIndicatorType.triangleSkewSpin:
        type = Indicator.triangleSkewSpin;
        break;
      case LoadingIndicatorType.pacman:
        type = Indicator.pacman;
        break;
      case LoadingIndicatorType.ballGridBeat:
        type = Indicator.ballGridBeat;
        break;
      case LoadingIndicatorType.semiCircleSpin:
        type = Indicator.semiCircleSpin;
        break;
      case LoadingIndicatorType.ballRotateChase:
        type = Indicator.ballRotateChase;
        break;
      case LoadingIndicatorType.orbit:
        type = Indicator.orbit;
        break;
      case LoadingIndicatorType.audioEqualizer:
        type = Indicator.audioEqualizer;
        break;
      case LoadingIndicatorType.circleStrokeSpin:
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
