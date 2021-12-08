import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ToastWidgetStatus { idle, show, hide }

class ToastWidget extends StatelessWidget {
  final ToastWidgetController _controller = ToastWidgetController();
  final Duration showDuration;
  final Duration hideDuration;

  ToastWidget({
    Key? key,
    Widget? contentWidget,
    dynamic data,
    this.showDuration = const Duration(milliseconds: 250),
    this.hideDuration = const Duration(milliseconds: 250),
  }) : super(key: key) {
    _controller.contentWidget = contentWidget;
    _controller.data = data;
  }

  dynamic get data => _controller.data;

  ToastWidget setWidgetBuilder(Widget Function(ToastWidget)? builder) {
    if (builder != null) _controller.contentWidget = builder(this);
    return this;
  }

  ToastWidget setData(dynamic data) {
    _controller.data = data;
    return this;
  }

  ToastWidget show({Duration? afterDelay, Function(ToastWidget)? complete}) {
    if (afterDelay != null) {
      Future.delayed(afterDelay, () => _showProgress(complete: complete));
    } else {
      _showProgress(complete: complete);
    }
    return this;
  }

  ToastWidget hide({Duration? afterDelay, Function(ToastWidget)? complete}) {
    if (afterDelay != null) {
      Future.delayed(afterDelay, () => _hideProgress(complete: complete));
    } else {
      _hideProgress(complete: complete);
    }
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double opacity = 0;
      late Duration duration;
      Widget? contentWidget;

      switch (_controller.status.value) {
        case ToastWidgetStatus.idle:
          opacity = 0;
          duration = Duration.zero;
          contentWidget = null;
          break;
        case ToastWidgetStatus.show:
          opacity = 1;
          duration = showDuration;
          contentWidget = _controller.contentWidget;
          break;
        case ToastWidgetStatus.hide:
          opacity = 0;
          duration = hideDuration;
          contentWidget = _controller.contentWidget;
          break;
      }

      return AnimatedOpacity(opacity: opacity, duration: duration, child: contentWidget);
    });
  }

  void _showProgress({Function(ToastWidget)? complete}) {
    if (_controller.isShowing == false) {
      _controller.status.value = ToastWidgetStatus.show;
      _controller.isShowing = true;
      Future.delayed(showDuration, () {
        _controller.isShowing = false;
        if (complete != null) complete(this);
      });
    }
  }

  void _hideProgress({Function(ToastWidget)? complete}) {
    if (_controller.isHiding == false && _controller.status.value != ToastWidgetStatus.idle) {
      _controller.status.value = ToastWidgetStatus.hide;
      _controller.isHiding = true;
      Future.delayed(hideDuration, () {
        _controller.isHiding = false;
        _controller.status.value = ToastWidgetStatus.idle;
        if (complete != null) complete(this);
      });
    }
  }
}

class ToastWidgetController extends GetxController {
  bool isShowing = false;
  bool isHiding = false;
  Widget? contentWidget;
  dynamic data;
  Rx<ToastWidgetStatus> status = ToastWidgetStatus.idle.obs;
}
