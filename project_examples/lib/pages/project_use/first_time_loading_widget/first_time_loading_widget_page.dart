import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';

class FirstTimeLoadingWidgetPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const FirstTimeLoadingWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _FirstTimeLoadingWidgetPageState();
}

class _FirstTimeLoadingWidgetPageState extends NormalStatefulWidgetState<FirstTimeLoadingWidgetPage> {
  int _count = 0;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget firstTimeLoadingWidgetStartLoading(BuildContext context) {
    return firstTimeLoadingWidget.listenFuture(() => _future()).onSuccess((p0) => appPrintSuccess(p0)).onError(
          (p0) => appPrintError(p0),
        );
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
