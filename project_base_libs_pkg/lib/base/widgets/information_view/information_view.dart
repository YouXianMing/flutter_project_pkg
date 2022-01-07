import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base_file_headers.dart';

class InformationView<T extends BaseInformationViewConfig> extends StatelessWidget with MaybePopMixin {
  /// 控制器
  final _InformationViewController _controller = _InformationViewController();

  /// 类型
  final AnimatedWidgetType type;

  /// 配置
  final T? config;

  /// 延迟build,当InformationView临时添加到一个控件上时,因为来不及build,直接调用show的话会导致没有动画效果,默认为false
  final bool waitForBuild;

  /// 延迟build的时间间隔,默认为30ms
  final Duration waitForBuildDuration;

  /// debug打印
  final bool? debugPrintInfo;

  /// 数据
  dynamic get data => _controller.data;

  /// 显示动画当中
  bool get isShowing => _controller.isShowing;

  /// 隐藏动画当中
  bool get isHiding => _controller.isHiding;

  /// 处于活动当中(调用了show方法时就开始处于活动当中,为true,在控件完全消失后才会重新设置成false)
  bool get isInProgress => _controller.isInProgress;

  /// 当前所处状态
  InformationViewStatus get currentStatus => _controller.step.value;

  InformationView({
    Key? key,
    dynamic data,
    Widget Function(InformationView)? builder,
    void Function(InformationView)? self,
    required this.type,
    this.config,
    this.waitForBuild = false,
    this.waitForBuildDuration = const Duration(milliseconds: 30),
    this.debugPrintInfo,
  }) : super(key: key) {
    if (builder != null) _controller.contentWidget = builder(this);
    if (self != null) self(this);
    _controller.data = data;
  }

  /// 用于处理响应物理返回键时所用(实际上是被MaybePopManager托管来处理)
  InformationView managerMaybePopEvent({bool hostByMaybePopManager = true, bool blockMaybePopEvent = false}) {
    _controller.hostByMaybePopManager = hostByMaybePopManager;
    _controller.blockMaybePopEvent = blockMaybePopEvent;
    return this;
  }

  /// 在Overlay中显示,显示结束后自动移除
  InformationView inOverlay(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(builder: (_) => this);
    Overlay.of(context)!.insert(overlayEntry);
    _controller.extData = overlayEntry;
    return this;
  }

  /// 在StackContainer中显示,显示结束后自动移除
  InformationView inStackContainer(StackContainer container) {
    container.insertWidget(this);
    _controller.extData = container;
    return this;
  }

  /// 显示
  InformationView show({Duration? afterDelay, Function(InformationView)? complete}) {
    if (_controller.hostByMaybePopManager) addToMaybePopManager();

    // 处于活动当中
    _controller.isInProgress = true;

    // 设置显示结束后的回调
    _controller.didCompleteShowCallback = complete;

    // afterDelay的优先级要比waitForBuildDuration的优先级要高
    Duration? duration;
    if (afterDelay != null) {
      duration = afterDelay;
    } else if (waitForBuild == true) {
      duration = waitForBuildDuration;
    }

    if (duration != null) {
      Future.delayed(duration, () {
        _controller.step.value = InformationViewStatus.show;
      });
    } else {
      _controller.step.value = InformationViewStatus.show;
    }

    return this;
  }

  /// 隐藏
  InformationView hide({Duration? afterDelay, Function(InformationView)? complete}) {
    // 设置隐藏结束后的回调
    _controller.didCompleteHideCallback = complete;

    // afterDelay的优先级要比waitForBuildDuration的优先级要高
    Duration? duration;
    if (afterDelay != null) {
      duration = afterDelay;
    } else if (waitForBuild == true) {
      duration = waitForBuildDuration;
    }

    if (duration != null) {
      Future.delayed(duration, () {
        // 如果当前处于prepare状态,则不执行任何操作,防止卡死
        if (_controller.step.value == InformationViewStatus.idle) return this;
        _controller.step.value = InformationViewStatus.hide;
      });
    } else {
      // 如果当前处于prepare状态,则不执行任何操作,防止卡死
      if (_controller.step.value == InformationViewStatus.idle) return this;
      _controller.step.value = InformationViewStatus.hide;
    }

    return this;
  }

  /// 背景点击
  InformationView setBackgroundTap(Function(InformationView) callback) {
    _controller.backgroundTapCallback = callback;
    return this;
  }

  /// 控件构建
  InformationView setWidgetBuilder(Widget Function(InformationView) builder) {
    _controller.contentWidget = builder(this);
    return this;
  }

  /// 设置数据
  InformationView setData(dynamic data) {
    _controller.data = data;
    return this;
  }

  /// debug打印信息
  void _debugInfo(String text) {
    if (debugPrintInfo == true) {
      // ignore: avoid_print
      print('$runtimeType:$hashCode $text');
    }
  }

  /// 移除额外的数据,如OverlayEntry,StackContainer等
  void _removeExtData() {
    if (_controller.extData != null) {
      _debugInfo('从${_controller.extData}上移除了');
    }

    if (_controller.extData is OverlayEntry) {
      (_controller.extData as OverlayEntry).remove();
    } else if (_controller.extData is StackContainer) {
      (_controller.extData as StackContainer).deleteWidget(this);
    }

    _controller.extData = null;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.step.value == InformationViewStatus.idle) {
        _debugInfo('[0.准备阶段]');
        _controller.isShowing = false;
        _controller.isHiding = false;
      } else if (_controller.step.value == InformationViewStatus.show) {
        _debugInfo('[1.显示动画]');
        _controller.isShowing = true;
      } else if (_controller.step.value == InformationViewStatus.hide) {
        _debugInfo('[2.隐藏动画]');
        _controller.isHiding = true;
      }

      return AnimatedWidgetFactory.animatedWidget(
          type: type,
          step: _controller.step.value,
          widget: _controller.contentWidget!,
          config: config,
          didCompleteShowCallback: () {
            _debugInfo('[SHOW END]');
            _controller.isShowing = false;
            if (_controller.didCompleteShowCallback != null) _controller.didCompleteShowCallback!(this);
          },
          didCompleteHideCallback: () {
            _debugInfo('[HIDE END]');
            _controller.isHiding = true;
            _controller.step.value = InformationViewStatus.idle;
            _controller.isInProgress = false;
            if (_controller.hostByMaybePopManager) removeFromMaybePopManager();
            if (waitForBuild == true) {
              Future.delayed(waitForBuildDuration, () {
                if (_controller.didCompleteHideCallback != null) _controller.didCompleteHideCallback!(this);
                _removeExtData();
              });
            } else {
              if (_controller.didCompleteHideCallback != null) _controller.didCompleteHideCallback!(this);
              _removeExtData();
            }
          },
          backgroundTapCallback: () {
            _debugInfo('[BACKGROUND TAP]');
            if (_controller.backgroundTapCallback != null) _controller.backgroundTapCallback!(this);
          })!;
    });
  }

  @override
  bool? pageMaybePop() {
    // 如果设置了屏蔽物理返回键,则此处始终返回false
    if (_controller.blockMaybePopEvent == true) {
      return false;
    }

    // 处于动画当中不允许操作
    if (_controller.isShowing || _controller.isShowing) {
      return false;
    }

    // 开始处理物理返回键事件,处理开始时设置startAccessMaybePopEvent为true,动画结束后设置为false,防止重复hide
    if (_controller.startAccessMaybePopEvent == false) {
      _controller.startAccessMaybePopEvent = true;
      hide(complete: (t) => _controller.startAccessMaybePopEvent = false);
    }

    // MaybePopMixin中的方法,如果当前informationView处于活动中,则认为不能pop
    return !_controller.isInProgress;
  }
}

class _InformationViewController extends GetxController {
  /// 内容widget
  Widget? contentWidget;

  /// 额外的数据,如OverlayEntry,StackContainer等
  dynamic extData;

  /// 步骤,默认为idle(准备阶段)
  final Rx<InformationViewStatus> step = InformationViewStatus.idle.obs;

  /// 数据
  dynamic data;

  /// 显示动画当中
  bool isShowing = false;

  /// 隐藏动画当中
  bool isHiding = false;

  /// 处于活动当中(调用了show方法时就开始处于活动当中,为true,在控件完全消失后才会重新设置成false)
  bool isInProgress = false;

  /// 被MaybePopManager接管,用于处理物理返回键事件
  bool hostByMaybePopManager = false;

  /// 屏蔽物理返回键事件,默认值为false,只有在hostByMaybePopManager时此参数设置才有意义
  bool blockMaybePopEvent = false;

  /// 开始处理MaybePop事件,在pageMaybePop()中使用
  bool startAccessMaybePopEvent = false;

  /// 动画显示结束后的回调
  Function(InformationView)? didCompleteShowCallback;

  /// 动画隐藏结束后的回调
  Function(InformationView)? didCompleteHideCallback;

  /// 动画隐藏结束后的回调
  Function(InformationView)? backgroundTapCallback;
}
