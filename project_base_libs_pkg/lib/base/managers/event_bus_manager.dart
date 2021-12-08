import 'dart:async';
import 'package:event_bus/event_bus.dart';

abstract class AppBaseEvent {
  /// (abstract) 标记
  String? get mark;
  set mark(String? val);
}

class EventBusManager {
  static EventBus? _eventBus;
  static EventBusManager? _instance;

  /// 构造方法创建单例
  factory EventBusManager() => getInstance;

  /// 私有构造方法
  EventBusManager._internal() {
    _eventBus ??= EventBus();
  }

  static EventBusManager get getInstance {
    _instance ??= EventBusManager._internal();
    return _instance!;
  }

  EventBus get _getEventBus => _eventBus!;

  /// 订阅一个事件
  StreamSubscription<T> listen<T extends AppBaseEvent>(Function(T event) onData) {
    /// 内部流属于广播模式，可以有多个订阅者
    return EventBusManager.getInstance._getEventBus.on<T>().listen(onData);
  }

  /// 订阅所有事件
  StreamSubscription listenAll(Function(dynamic)? onData) {
    return EventBusManager.getInstance._getEventBus.on().listen(onData);
  }

  /// 发送事件
  void fire<T extends AppBaseEvent>(T e) {
    EventBusManager.getInstance._getEventBus.fire(e);
  }
}
