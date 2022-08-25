import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class IsolatePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const IsolatePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => CompleterPageState();
}

class CompleterPageState extends NormalStatefulWidgetState<IsolatePage> {
  final receivePort = ReceivePort();
  late String info = '等待中';

  @override
  void initState() {
    super.initState();
    startIsolate();
  }

  void startIsolate() async {
    // 传输多个参数
    // https://stackoverflow.com/questions/63707220/how-to-pass-arguments-besides-sendport-to-a-spawned-isolate-in-dart
    final isolate = await Isolate.spawn(isolateMethod, [receivePort.sendPort, 3]);

    receivePort.listen((message) {
      // 更新数据
      info = message.toString();
      setState(() {});

      // 关闭receivePort
      receivePort.close();

      // 杀死isolate
      isolate.kill();
    });
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Center(child: WidgetsFactory.text(info));
  }
}

void isolateMethod(List<dynamic> arguments) async {
  SendPort sendPort = arguments[0];
  int number = arguments[1];
  await Future.delayed(const Duration(seconds: 2));
  sendPort.send(42 + number);
}
