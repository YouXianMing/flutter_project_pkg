import 'package:flutter/material.dart';

/// 线条位置的枚举值
enum LinePosition {
  /// 线条从左边开始
  startFromLeft,

  /// 线条从中间开始
  startFromRight,

  /// 线条从中间开始
  startFromCenter,
}

/// 线条样式的百分比控件(没有动画效果)
class LinePercentWidget extends StatelessWidget {
  /// 百分比的数值,取值范围在0~1之间,低于0会取0,高于1会取1
  final double percent;

  /// 线条位置
  final LinePosition linePosition;

  /// 线条高度,默认10
  final double height;

  /// 线条宽度,默认为double.infinity
  final double width;

  /// 背景色,默认灰色
  final Color backgroundColor;

  /// 线条颜色,默认红色
  final Color lineColor;

  /// 背景的BorderRadius,默认为BorderRadius.all(Radius.circular(5))
  final BorderRadius backgroundBorderRadius;

  /// 线条的BorderRadius,默认为BorderRadius.all(Radius.circular(5))
  final BorderRadius lineBorderRadius;

  const LinePercentWidget({
    Key? key,
    required this.percent,
    this.linePosition = LinePosition.startFromLeft,
    this.height = 10,
    this.width = double.infinity,
    this.backgroundColor = Colors.grey,
    this.lineColor = Colors.red,
    this.backgroundBorderRadius = const BorderRadius.all(Radius.circular(5)),
    this.lineBorderRadius = const BorderRadius.all(Radius.circular(5)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      alignment: _alignment,
      decoration: BoxDecoration(color: backgroundColor, borderRadius: backgroundBorderRadius),
      child: FractionallySizedBox(
        widthFactor: _percent,
        child: Container(decoration: BoxDecoration(color: lineColor, borderRadius: lineBorderRadius)),
      ),
    );
  }

  double get _percent {
    if (percent > 1) {
      return 1;
    } else if (percent < 0) {
      return 0;
    } else {
      return percent;
    }
  }

  Alignment get _alignment {
    switch (linePosition) {
      case LinePosition.startFromLeft:
        return Alignment.centerLeft;

      case LinePosition.startFromRight:
        return Alignment.centerRight;

      case LinePosition.startFromCenter:
        return Alignment.center;
    }
  }
}
