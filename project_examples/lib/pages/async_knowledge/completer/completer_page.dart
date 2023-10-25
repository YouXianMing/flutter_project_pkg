import 'dart:async';

import 'package:project_base_libs_pkg/base/widgets/widgets_factory/widgets_factory.dart';
import 'package:project_examples/file_headers.dart';

class CompleterPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const CompleterPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => CompleterPageState();
}

class CompleterPageState extends NormalStatefulWidgetState<CompleterPage> {
  // 相当于信号量
  late Completer _completer;
  String _info = '等待中'.tr;

  @override
  void initState() {
    super.initState();
    _completer = Completer();
    startFuture();
  }

  void startFuture() async {
    Future.delayed(Duration(seconds: Util.randomInt(max: 4, min: 1)), () => _completer.complete('结果'.tr));
    _info = await _completer.future;
    safeSetState(() {});
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
