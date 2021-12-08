import 'dart:async';

class DartSemaphore {
  /// 存储Completer的数组
  final List<Completer> _completerList = [];

  /// 每执行一次wait会添加一个Completer到数组中
  Future<dynamic> wait() {
    Completer completer = Completer();
    _completerList.add(completer);
    return completer.future;
  }

  /// 发送信号量后删除数组中的第一个Completer
  void signal({dynamic value}) {
    if (_completerList.isNotEmpty) {
      _completerList.first.complete(value);
      _completerList.removeAt(0);
    }
  }
}
