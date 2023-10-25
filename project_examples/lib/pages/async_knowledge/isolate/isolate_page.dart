import 'dart:isolate';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class IsolatePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const IsolatePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => CompleterPageState();
}

class CompleterPageState extends NormalStatefulWidgetState<IsolatePage> {
  final _receivePort = ReceivePort();
  late String _info = '等待中';

  @override
  void initState() {
    super.initState();
    startIsolate();
  }

  void startIsolate() async {
    // 传输多个参数
    // https://stackoverflow.com/questions/63707220/how-to-pass-arguments-besides-sendport-to-a-spawned-isolate-in-dart
    final isolate = await Isolate.spawn(isolateMethod, [_receivePort.sendPort, 3]);

    _receivePort.listen((message) {
      // 更新数据
      _info = message.toString();
      setState(() {});

      // 关闭receivePort
      _receivePort.close();

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
    return Center(child: WidgetsFactory.text(_info));
  }
}

void isolateMethod(List<dynamic> arguments) async {
  SendPort sendPort = arguments[0];
  int number = arguments[1];
  await Future.delayed(const Duration(seconds: 2));
  sendPort.send(42 + number);
}
