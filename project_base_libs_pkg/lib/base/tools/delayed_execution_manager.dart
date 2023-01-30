import 'dart:async';

/// 延时执行管理器
class DelayedExecutionManager {
  /// 定时器
  Timer? _timer;

  /// 延时时间,默认为400
  final int milliseconds;

  DelayedExecutionManager({this.milliseconds = 400});

  /// 延时开始执行
  void delay({required Function execute}) {
    /// 取消上一次的定时器
    if (_timer != null) _timer!.cancel();

    /// 执行定时器
    _timer = Timer(Duration(milliseconds: milliseconds <= 0 ? 400 : milliseconds), () => execute());
  }

  /// 取消执行
  void cancelExecute() {
    if (_timer != null) _timer!.cancel();
  }
}
