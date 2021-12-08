import 'package:flutter/material.dart';

extension CurveExtensions on Curve {
  /// 生成Interval
  Interval withInterval(double begin, double end) => Interval(begin, end, curve: this);
}
