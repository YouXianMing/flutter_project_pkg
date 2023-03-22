import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/base/normal_stateful_v2_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';

class FutureLoadingWidgetPage extends NormalStatefulV2Widget {
  @override
  final PageArguments? arguments;

  const FutureLoadingWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _FutureLoadingWidgetPageState();
}

class _FutureLoadingWidgetPageState extends NormalStatefulWidgetV2State<FutureLoadingWidgetPage> {
  int _count = 0;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget futureLoadingWidget(FutureLoadingWidgetController controller) {
    controller.setFuture((p0) => _future()).startListen(
          successCallback: (p0) => appPrintSuccess(p0),
          failedCallback: (p0) => appPrintError(p0),
        );

    return super.futureLoadingWidget(controller);
  }

  /// 模拟future对象
  Future _future() {
    Completer completer = Completer();
    Util.delayedMilliseconds(1500, () {
      if (_count++ >= 2) {
        completer.complete('success data');
      } else {
        completer.completeError('error data');
      }
    });
    return completer.future;
  }

  @override
  Widget body(BuildContext context) {
    return Container();
  }
}
