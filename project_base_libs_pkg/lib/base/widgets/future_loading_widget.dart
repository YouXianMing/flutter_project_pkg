import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/animated_switcher_widget.dart';
import 'package:project_base_libs_pkg/base/widgets/custom_stateful_widget_mixin.dart';

enum FutureLoadingStatus {
  /// idle
  idle,

  /// 开始加载
  loading,

  /// 失败了
  failed,

  /// 完成了
  done,
}

class FutureLoadingWidgetController {
  FutureLoadingWidgetController({
    FutureLoadingStatus initStatus = FutureLoadingStatus.idle,
    dynamic idleData,
    Widget Function(dynamic data)? idleWidgetBuilder,
    dynamic loadingData,
    Widget Function(dynamic data)? loadingWidgetBuilder,
    Widget Function(dynamic data, void Function() retry)? failedWidgetBuilder,
    dynamic futureData,
    Future Function(dynamic)? future,
    List<Future> Function(dynamic)? futures,
    bool requestOnlyOnce = true,
    Duration? startLoadingDelayDuration,
    Duration? changeToDoneDelayDuration,
  }) {
    _currentStatus = initStatus;
    _idleData = idleData;
    _idleWidgetBuilder = idleWidgetBuilder;
    _loadingData = loadingData;
    _loadingWidgetBuilder = loadingWidgetBuilder;
    _failedWidgetBuilder = failedWidgetBuilder;
    _futureData = futureData;
    _future = future;
    _futures = futures;
    _requestOnlyOnce = requestOnlyOnce;
    _startLoadingDelayDuration = startLoadingDelayDuration;
    _changeToDoneDelayDuration = changeToDoneDelayDuration;
  }

  /// 开始Future或者Future数组事件(所有内容设置完后再调用start方法)
  FutureLoadingWidgetController startListen({Function(dynamic data)? successCallback, Function(dynamic data)? failedCallback}) {
    _successCallback = successCallback;
    _failedCallback = failedCallback;
    if (_requestOnlyOnce == true) {
      if (_didStartRequest == false) _startFutureIfNeeded();
    } else {
      _startFutureIfNeeded();
    }

    return this;
  }

  /// 设置idle状态下Widget的回调的数据
  FutureLoadingWidgetController setIdleData(dynamic idleData) {
    _idleData = idleData;
    return this;
  }

  /// 设置idle状态下widget的构造器
  FutureLoadingWidgetController setIdleWidgetBuilder(Widget Function(dynamic data) idleWidgetBuilder) {
    _idleWidgetBuilder = idleWidgetBuilder;
    return this;
  }

  /// 设置loadingWidget的回调的数据
  FutureLoadingWidgetController setLoadingData(dynamic loadingData) {
    _loadingData = loadingData;
    return this;
  }

  /// 设置加载widget的构造器
  FutureLoadingWidgetController setLoadingWidgetBuilder(Widget Function(dynamic data) loadingWidgetBuilder) {
    _loadingWidgetBuilder = loadingWidgetBuilder;
    return this;
  }

  /// 设置失败widget的构造器,其中retry必须由构造的widget调用
  FutureLoadingWidgetController setFailedWidgetBuilder(Widget Function(dynamic data, void Function() retry)? failedWidgetBuilder) {
    _failedWidgetBuilder = failedWidgetBuilder;
    return this;
  }

  /// 设置初始化数据,在setFuture方法的回调中可以取到该值
  FutureLoadingWidgetController setFutureData(dynamic initData) {
    _futureData = initData;
    return this;
  }

  FutureLoadingWidgetController setFuture(Future Function(dynamic)? future) {
    _future = future;
    return this;
  }

  FutureLoadingWidgetController setFutures(List<Future> Function(dynamic)? futures) {
    _futures = futures;
    return this;
  }

  /// 设置是否只请求一次
  FutureLoadingWidgetController setRequestOnlyOnce(bool requestOnlyOnce) {
    _requestOnlyOnce = requestOnlyOnce;
    return this;
  }

  /// 设置开始请求时的获取Future的延时时间
  FutureLoadingWidgetController setStartLoadingDelayDuration(Duration duration) {
    _startLoadingDelayDuration = duration;
    return this;
  }

  /// 设置切换到done状态时的延时时间
  FutureLoadingWidgetController setChangeToDoneDelayDuration(Duration duration) {
    _changeToDoneDelayDuration = duration;
    return this;
  }

  /// 当前状态
  FutureLoadingStatus _currentStatus = FutureLoadingStatus.idle;

  /// future对象
  Future Function(dynamic)? _future;

  /// future数组
  List<Future> Function(dynamic)? _futures;

  /// 初始化数据
  dynamic _futureData;

  /// idle状态时的数据
  dynamic _idleData;

  /// 加载时widget的数据
  dynamic _loadingData;

  /// 成功时widget的数据
  dynamic _successData;

  /// 失败时widget的数据
  dynamic _failedData;

  /// idle状态下Widget的构造器
  Widget Function(dynamic data)? _idleWidgetBuilder;

  /// 加载时Widget的构造器
  Widget Function(dynamic data)? _loadingWidgetBuilder;

  /// 失败时widget的构造器
  Widget Function(dynamic data, void Function() retry)? _failedWidgetBuilder;

  /// 成功的回调
  Function(dynamic data)? _successCallback;

  /// 失败的回调
  Function(dynamic data)? _failedCallback;

  /// 是否已经开始请求
  bool _didStartRequest = false;

  /// 只请求一次,默认为true,表示listenFuture或者listenFutures只会在startListen方法中执行一次,防止setState()时重复调用
  bool _requestOnlyOnce = true;

  /// 开始请求时的获取Future的延时时间
  Duration? _startLoadingDelayDuration;

  /// 切换到done状态时的延时时间
  Duration? _changeToDoneDelayDuration;

  /// 持有state
  CustomStatefulWidgetStateMixin? _stateMixin;

  /// 切换到指定的状态
  FutureLoadingWidgetController _changeToStatus(FutureLoadingStatus status) {
    _currentStatus = status;
    if (_stateMixin != null) _stateMixin!.stateMixinSetState();
    return this;
  }

  /// 开始请求
  void _startFutureIfNeeded() {
    if (_future != null) {
      _didStartRequest = true;

      // 单个请求
      Future? future = _future!(_futureData);
      _changeToStatus(FutureLoadingStatus.loading);

      Future.delayed(_startLoadingDelayDuration ?? Duration.zero, () {
        Stream.fromFuture(future).listen((event) {
          // 成功的情形
          _successData = event;
          if (_successCallback != null) _successCallback!(_successData);
          Future.delayed(_changeToDoneDelayDuration ?? Duration.zero, () => _changeToStatus(FutureLoadingStatus.done));
        }, onError: (error) {
          // 失败的情形
          _failedData = error;
          if (_failedCallback != null) _failedCallback!(_failedData);
          _changeToStatus(FutureLoadingStatus.failed);
        });
      });
    } else if (_futures != null) {
      _didStartRequest = true;

      // 多个请求
      List<Future>? futures = _futures!(_futureData);
      _changeToStatus(FutureLoadingStatus.loading);

      Future.delayed(_startLoadingDelayDuration ?? Duration.zero, () {
        Future.wait(futures).onError((error, stackTrace) {
          // 失败的情形
          _failedData = error;
          if (_failedCallback != null) _failedCallback!(_failedData);
          _changeToStatus(FutureLoadingStatus.failed);
          return Future.error(error!);
        }).then((value) {
          // 成功的情形
          _successData = value;
          if (_successCallback != null) _successCallback!(_successData);
          Future.delayed(_changeToDoneDelayDuration ?? Duration.zero, () => _changeToStatus(FutureLoadingStatus.done));
        });
      });
    } else {
      _changeToStatus(FutureLoadingStatus.idle);
    }
  }
}

class FutureLoadingWidget extends StatefulWidget {
  /// 逻辑控制器
  final FutureLoadingWidgetController controller;

  /// 背景色,默认是透明色
  final Color backgroundColor;

  /// 动画时间,默认为200毫秒
  final Duration duration;

  /// 反转动画时间
  final Duration? reverseDuration;

  /// transition builder
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

  /// layout builder
  final AnimatedSwitcherLayoutBuilder layoutBuilder;

  /// switch in curve
  final Curve switchInCurve;

  /// switch out curve
  final Curve switchOutCurve;

  const FutureLoadingWidget({
    Key? key,
    required this.controller,
    this.backgroundColor = Colors.transparent,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder,
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FutureLoadingWidgetState();
}

class FutureLoadingWidgetState extends State<FutureLoadingWidget> with CustomStatefulWidgetStateMixin {
  @override
  Widget build(BuildContext context) {
    late bool ignoring;
    late Widget child;
    switch (widget.controller._currentStatus) {
      case FutureLoadingStatus.idle:
        ignoring = widget.controller._idleWidgetBuilder == null;
        child =
            widget.controller._idleWidgetBuilder != null ? widget.controller._idleWidgetBuilder!(widget.controller._idleData) : Container();
        break;
      case FutureLoadingStatus.loading:
        ignoring = false;
        child = widget.controller._loadingWidgetBuilder != null
            ? widget.controller._loadingWidgetBuilder!(widget.controller._loadingData)
            : Container(alignment: Alignment.center, color: Colors.white, child: const CupertinoActivityIndicator());
        break;
      case FutureLoadingStatus.failed:
        ignoring = false;
        child = widget.controller._failedWidgetBuilder != null
            ? widget.controller._failedWidgetBuilder!(widget.controller._failedData, () => widget.controller._startFutureIfNeeded())
            : Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () => widget.controller._startFutureIfNeeded(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    color: Colors.indigoAccent,
                    child: const Text('Tap to retry', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              );
        break;
      case FutureLoadingStatus.done:
        ignoring = true;
        child = Container();
        break;
    }

    return IgnorePointer(
      ignoring: ignoring,
      child: Container(
        color: widget.backgroundColor,
        child: AnimatedSwitcherWidget(
          duration: widget.duration,
          reverseDuration: widget.reverseDuration,
          transitionBuilder: widget.transitionBuilder,
          layoutBuilder: widget.layoutBuilder,
          switchOutCurve: widget.switchOutCurve,
          switchInCurve: widget.switchInCurve,
          builder: (c, d) => child,
          valueKey: ValueKey(widget.controller._currentStatus),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.controller._stateMixin = this;
  }

  @override
  void didUpdateWidget(covariant FutureLoadingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller._stateMixin = this;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller._stateMixin = this;
  }

  // --- CustomStatefulWidgetMixin --- //

  @override
  void stateMixinSetState() {
    if (mounted) setState(() {});
  }

  @override
  bool get stateMixinIsMounted => mounted;

  @override
  BuildContext get stateMixinBuildContext => context;
}
