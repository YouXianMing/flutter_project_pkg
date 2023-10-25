import 'package:project_examples/file_headers.dart';

class AsyncAwaitExamplePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const AsyncAwaitExamplePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AsyncAwaitExamplePageState();
}

class AsyncAwaitExamplePageState extends NormalStatefulWidgetState<AsyncAwaitExamplePage> {
  final _info = ''.obs;

  void updateInfo(text) => _info.value = text;

  Future<String> futureEvent() => Future.delayed(const Duration(seconds: 2), () => '数据');

  /// 对Future对象使用await会导致阻塞,且方法需要标记为async,直接调用该方法不会导致阻塞
  Future<void> start() async {
    updateInfo('阻塞中...');
    var result = await futureEvent();
    updateInfo('结果: $result');
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) => Center(child: Obx(() => Text(_info.value)));
}
