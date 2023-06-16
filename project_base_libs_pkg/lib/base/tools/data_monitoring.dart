/// 监测数值变化用的类
class DataMonitoring<T> {
  T? _currentValue;

  DataMonitoring({T? initValue}) {
    _currentValue = initValue;
  }

  /// 当前值是否发生了变化
  bool didChanged(T? newValue) {
    if (_currentValue != newValue) {
      _currentValue = newValue;
      return true;
    } else {
      return false;
    }
  }

  /// 获取当前值
  T? get currentValue => _currentValue;
}
