import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum FirstTimeLoadingWidgetStatus {
  /// idle
  idle,

  /// 开始
  start,

  /// 成功了
  success,

  /// 失败了
  failed,

  /// 完成了,并移除了当前的widget
  done,
}

class _FirstTimeLoadingWidgetController extends GetxController {
  /// 当前控制器的状态
  final Rx<FirstTimeLoadingWidgetStatus> status = FirstTimeLoadingWidgetStatus.idle.obs;

  /// 是否可以点击重试按钮
  bool canTapReloadButton = false;

  /// future对象
  Future Function()? future;

  /// future数组
  List<Future> Function()? futures;

  /// 成功的回调
  Function(dynamic data)? successCallback;

  /// 失败的回调
  Function(dynamic data)? errorCallback;

  /// 加载页面的builder
  Widget Function(dynamic data)? loadingWidgetBuilder;

  /// 加载页面builder的配置数据,有需要时可以设置
  dynamic loadingWidgetBuilderConfigData;

  /// 出错页面的builder
  Widget Function(void Function() onPressed, dynamic error)? errorWidgetBuilder;

  /// 记录error,用于传给errorWidgetBuilder中使用
  dynamic errorWidgetBuilderData;

  /// 背景色,如果没有设置,默认为白色
  Color? backgroundColor;

  /// 是否延迟构建
  bool? waitBuildFuture;

  /// 延迟构建的时间
  Duration? waitBuildFutureDuration;

  /// 设置Future成功后切换到success的延迟时间,默认为null(切换到成功状态后,会直接调用successCallback,然后遮挡的UI会立马消失,设置了此值后,会延迟遮挡UI消失的时间)
  Duration? successStatusDelayDuration;

  /// 是否已经开始请求
  bool didStartRequest = false;
}

class FirstTimeLoadingWidget extends StatefulWidget {
  final _FirstTimeLoadingWidgetController _controller = _FirstTimeLoadingWidgetController();

  FirstTimeLoadingWidget({
    Key? key,
    Future Function()? future, // 单个的future
    List<Future> Function()? futures, // 异步的futures数组
    Function(dynamic)? success, // 成功的回调
    Function(dynamic)? error, // 失败的回调
    dynamic loadingWidgetBuilderConfigData, // 加载页面builder的配置数据,有需要时可以设置
    Widget Function(dynamic config)? loadingWidgetBuilder, // 加载菊花界面的控件构建,如果为空,则有默认构建
    Widget Function(void Function() onPressed, dynamic errorData)? errorWidgetBuilder, // 出错界面的控件构建,如果为空,则有默认构建(请将onPressed赋值给点击事件)
    bool waitBuildFuture = false, // Future结果延迟返回
    Duration waitBuildFutureDuration = const Duration(milliseconds: 150), // Future结果延迟返回的时间
    Duration? successStatusDelayDuration, // 设置Future成功后切换到success的延迟时间,默认为null
    Color? backgroundColor,
    this.successImmediately = false, // 是否立即成功,默认为false
    this.debugPrintInfo = false,
    this.requestOnlyOnce = true,
    this.removeWidgetsIfDone = true,
  }) : super(key: key) {
    {
      if (successImmediately == true) {
        _controller.status.value = FirstTimeLoadingWidgetStatus.done;
      } else {
        /// future与futures不能共存
        assert(!(future != null && futures != null));

        setLoadingWidgetBuilderConfigData(loadingWidgetBuilderConfigData);
        setLoadingWidgetBuilder(loadingWidgetBuilder);
        setErrorWidgetBuilder(errorWidgetBuilder);

        setWaitBuildFuture(waitBuildFuture);
        setWaitBuildFutureDuration(waitBuildFutureDuration);
        setToSuccessStatusDelayDuration(successStatusDelayDuration);
        setBackgroundColor(backgroundColor);

        onSuccess(success);
        onError(error);

        if (future != null) listenFuture(future);
        if (futures != null) listenFutures(futures);
      }
    }
  }

  /// 立即成功,对于不需要这个功能,可以设置此值
  final bool successImmediately;

  /// 只请求一次,默认为true,表示listenFuture或者listenFutures只会执行一次
  final bool requestOnlyOnce;

  /// debug打印信息
  final bool debugPrintInfo;

  /// 如果完成了(进入了FirstTimeLoadingWidgetStatus.done),则删除widgets
  final bool removeWidgetsIfDone;

  @override
  State<StatefulWidget> createState() => _FirstTimeLoadingWidgetState();

  /// 如果Future成功,则获取到数据
  FirstTimeLoadingWidget onSuccess(Function(dynamic)? success) {
    _controller.successCallback = success;
    return this;
  }

  /// 如果Future失败,则获取到错误信息
  FirstTimeLoadingWidget onError(Function(dynamic)? error) {
    _controller.errorCallback = error;
    return this;
  }

  /// 直接设置到完成状态
  FirstTimeLoadingWidget setDone() {
    _controller.status.value = FirstTimeLoadingWidgetStatus.done;
    return this;
  }

  /// 加载菊花界面的控件构建配置数据
  FirstTimeLoadingWidget setLoadingWidgetBuilderConfigData(dynamic configData) {
    _controller.loadingWidgetBuilderConfigData = configData;
    return this;
  }

  /// 加载菊花界面的控件构建,如果为空,则有默认构建
  FirstTimeLoadingWidget setLoadingWidgetBuilder(Widget Function(dynamic data)? loadingWidgetBuilder) {
    _controller.loadingWidgetBuilder = loadingWidgetBuilder;
    return this;
  }

  /// 出错界面的控件构建,如果为空,则有默认构建
  FirstTimeLoadingWidget setErrorWidgetBuilder(Widget Function(void Function() onPressed, dynamic error)? errorWidgetBuilder) {
    _controller.errorWidgetBuilder = errorWidgetBuilder;
    return this;
  }

  /// 设置Future结果是否延迟返回
  FirstTimeLoadingWidget setWaitBuildFuture(bool wait) {
    _controller.waitBuildFuture = wait;
    return this;
  }

  /// 设置Future结果延迟返回的时间,需要waitBuildFuture为true生效
  FirstTimeLoadingWidget setWaitBuildFutureDuration(Duration duration) {
    _controller.waitBuildFutureDuration = duration;
    return this;
  }

  /// 设置Future成功后切换到success的延迟时间
  FirstTimeLoadingWidget setToSuccessStatusDelayDuration(Duration? duration) {
    _controller.successStatusDelayDuration = duration;
    return this;
  }

  /// 设置背景色,如果为空,则默认为白色
  FirstTimeLoadingWidget setBackgroundColor(Color? backgroundColor) {
    _controller.backgroundColor = backgroundColor;
    return this;
  }

  /// debug打印信息
  void _debugInfo(String text) {
    if (debugPrintInfo == true) {
      // ignore: avoid_print
      print('$runtimeType:$hashCode $text');
    }
  }

  /// 监听Future,如果返回正常的数据,则加载控件消失,如果返回Future.error,则进入到加载错误界面
  FirstTimeLoadingWidget listenFuture(Future Function()? future) {
    if (requestOnlyOnce) {
      if (_controller.didStartRequest == false) {
        _controller.didStartRequest = true;
        _controller.future = future;
        _startFutureIfNeeded();
      }
    } else {
      _controller.future = future;
      _startFutureIfNeeded();
    }

    return this;
  }

  /// 监听异步的Futures,如果返回正常的数据,则加载控件消失,如果返回Future.error,则进入到加载错误界面
  FirstTimeLoadingWidget listenFutures(List<Future> Function()? futures) {
    if (requestOnlyOnce) {
      if (_controller.didStartRequest == false) {
        _controller.didStartRequest = true;
        _controller.futures = futures;
        _startFuturesIfNeeded();
      }
    } else {
      _controller.futures = futures;
      _startFuturesIfNeeded();
    }

    return this;
  }

  /// 单个Future的请求
  void _startFutureIfNeeded() {
    // 单个请求
    Future? future;
    if (_controller.future != null) {
      future = _controller.future!();
    }

    if (future != null) {
      _controller.status.value = FirstTimeLoadingWidgetStatus.start;
      Stream.fromFuture(future).listen((event) => _changeToSuccessStatus(event), onError: (error) {
        _controller.errorWidgetBuilderData = error;
        if (_controller.errorCallback != null) {
          _controller.errorCallback!(error);
        }
        _controller.status.value = FirstTimeLoadingWidgetStatus.failed;
      });
    } else {
      _controller.status.value = FirstTimeLoadingWidgetStatus.idle;
    }
  }

  /// 多个异步Future的请求
  void _startFuturesIfNeeded() {
    // 多个请求
    List<Future>? futures;
    if (_controller.futures != null) {
      futures = _controller.futures!();
    }

    if (futures != null) {
      _controller.status.value = FirstTimeLoadingWidgetStatus.start;
      Future.wait(futures).onError((error, stackTrace) {
        _controller.errorWidgetBuilderData = error;
        if (_controller.errorCallback != null) {
          _controller.errorCallback!(error);
        }
        _controller.status.value = FirstTimeLoadingWidgetStatus.failed;
        return Future.error(error!);
      }).then((value) => _changeToSuccessStatus(value));
    } else {
      _controller.status.value = FirstTimeLoadingWidgetStatus.idle;
    }
  }

  void _changeToSuccessStatus(dynamic value) {
    _controller.errorWidgetBuilderData = null;
    if (_controller.waitBuildFuture == true) {
      Future.delayed(_controller.waitBuildFutureDuration!, () {
        if (_controller.successCallback != null) {
          _controller.successCallback!(value);
        }

        if (_controller.successStatusDelayDuration != null) {
          Future.delayed(_controller.successStatusDelayDuration!, () => _controller.status.value = FirstTimeLoadingWidgetStatus.success);
        } else {
          _controller.status.value = FirstTimeLoadingWidgetStatus.success;
        }
      });
    } else {
      if (_controller.successCallback != null) {
        _controller.successCallback!(value);
      }
      if (_controller.successStatusDelayDuration != null) {
        Future.delayed(_controller.successStatusDelayDuration!, () => _controller.status.value = FirstTimeLoadingWidgetStatus.success);
      } else {
        _controller.status.value = FirstTimeLoadingWidgetStatus.success;
      }
    }
  }
}

class _FirstTimeLoadingWidgetState extends State<FirstTimeLoadingWidget> with AutomaticKeepAliveClientMixin {
  _FirstTimeLoadingWidgetController get controller => widget._controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      // 外层Stack设置
      double? stackOpacity;
      Duration? stackOpacityDuration;

      // loading层设置
      double? loadingViewOpacity;
      Duration? loadingViewOpacityDuration;
      if (controller.status.value == FirstTimeLoadingWidgetStatus.idle) {
        widget._debugInfo('IDLE');

        // 外层Stack设置
        stackOpacity = 1;
        stackOpacityDuration = const Duration(milliseconds: 0);

        // loading层设置
        loadingViewOpacity = 1;
        loadingViewOpacityDuration = const Duration(milliseconds: 0);
      } else if (controller.status.value == FirstTimeLoadingWidgetStatus.start) {
        widget._debugInfo('START');

        // 外层Stack设置
        stackOpacity = 1;
        stackOpacityDuration = const Duration(milliseconds: 100);

        // loading层设置
        loadingViewOpacity = 1;
        loadingViewOpacityDuration = const Duration(milliseconds: 100);
      } else if (controller.status.value == FirstTimeLoadingWidgetStatus.success) {
        widget._debugInfo('SUCCESS');

        // 外层Stack设置
        stackOpacity = 0;
        stackOpacityDuration = const Duration(milliseconds: 100);

        // loading层设置
        loadingViewOpacity = 1;
        loadingViewOpacityDuration = const Duration(milliseconds: 0);
      } else if (controller.status.value == FirstTimeLoadingWidgetStatus.failed) {
        widget._debugInfo('FAILED');

        // 外层Stack设置
        stackOpacity = 1;
        stackOpacityDuration = const Duration(milliseconds: 0);

        // loading层设置
        loadingViewOpacity = 0;
        loadingViewOpacityDuration = const Duration(milliseconds: 100);
      }

      if (controller.status.value == FirstTimeLoadingWidgetStatus.done) {
        widget._debugInfo('DONE');
        if (widget.removeWidgetsIfDone) {
          controller.loadingWidgetBuilder = null;
          controller.errorWidgetBuilder = null;
        }
        return const IgnorePointer();
      } else {
        return AnimatedOpacity(
            duration: stackOpacityDuration!,
            opacity: stackOpacity!,
            onEnd: () {
              if (controller.status.value == FirstTimeLoadingWidgetStatus.success) {
                controller.status.value = FirstTimeLoadingWidgetStatus.done;
              }
            },
            child: Stack(
              children: [
                Container(
                  color: controller.backgroundColor ?? Colors.white,
                  child: _errorWidget(
                      error: widget._controller.errorWidgetBuilderData,
                      onPressed: () {
                        if (controller.status.value == FirstTimeLoadingWidgetStatus.failed && controller.canTapReloadButton == true) {
                          if (controller.future != null) {
                            widget._startFutureIfNeeded();
                          } else if (controller.futures != null) {
                            widget._startFuturesIfNeeded();
                          }
                        }
                      }),
                ),
                IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: loadingViewOpacity!,
                    duration: loadingViewOpacityDuration!,
                    onEnd: () {
                      if (controller.status.value == FirstTimeLoadingWidgetStatus.failed) {
                        controller.canTapReloadButton = true;
                      } else {
                        controller.canTapReloadButton = false;
                      }
                    },
                    child: _loadingWidget(),
                  ),
                )
              ],
            ));
      }
    });
  }

  Widget _loadingWidget() {
    // 如果loadingWidgetBuilder有值并提供了Widget,则使用loadingWidgetBuilder中的widget
    if (controller.loadingWidgetBuilder != null) {
      return controller.loadingWidgetBuilder!(widget._controller.loadingWidgetBuilderConfigData);
    }

    return Container(
      color: Colors.white,
      child: const Center(child: CupertinoActivityIndicator()),
    );
  }

  Widget _errorWidget({required void Function() onPressed, required dynamic error}) {
    // 如果errorWidgetBuilder有值并提供了Widget,则使用errorWidgetBuilder中的widget
    if (controller.errorWidgetBuilder != null) {
      return controller.errorWidgetBuilder!(onPressed, error);
    }

    Color color = Colors.blueAccent;
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.refresh, size: 30, color: color),
              const Padding(padding: EdgeInsets.all(10)),
              DefaultTextStyle(style: TextStyle(color: color, fontSize: 14), child: const Text('点击重试')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
