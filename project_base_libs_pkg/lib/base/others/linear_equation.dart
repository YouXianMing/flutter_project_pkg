/// 坐标点
class MATHPoint {
  final double x;
  final double y;
  MATHPoint({required this.x, required this.y});
}

/// 一元一次方程 Y = kX + b
class LinearEquation {
  late double k;
  late double b;
  bool didCalculate = false;

  /// 开始计算斜率k,参数b
  LinearEquation startCalculateWith({required MATHPoint pointA, required MATHPoint pointB}) {
    k = _calculateSlope(pointA.x, pointA.y, pointB.x, pointB.y);
    b = _calculateConstant(pointA.x, pointA.y, pointB.x, pointB.y);
    return this;
  }

  /// 开始计算斜率k,参数b(只计算一次,后续重复调用无效)
  void startCalculateOnlyOnceWith({required MATHPoint pointA, required MATHPoint pointB}) {
    if (didCalculate == false) {
      didCalculate = true;
      k = _calculateSlope(pointA.x, pointA.y, pointB.x, pointB.y);
      b = _calculateConstant(pointA.x, pointA.y, pointB.x, pointB.y);
    }
  }

  /// 计算斜率k
  double _calculateSlope(double x1, double y1, double x2, double y2) {
    if (x2 == x1) return 0;
    return (y2 - y1) / (x2 - x1);
  }

  /// 计算参数b
  double _calculateConstant(double x1, double y1, double x2, double y2) {
    if (x2 == x1) return 0;
    return (y1 * (x2 - x1) - x1 * (y2 - y1)) / (x2 - x1);
  }

  /// 通过y值获取x值
  double xValueWhenYEqual(double yValue) {
    if (k == 0) return 0;
    return (yValue - b) / k;
  }

  /// 通过x值获取y值
  double yValueWhenXEqual(double xValue) {
    return k * xValue + b;
  }
}
