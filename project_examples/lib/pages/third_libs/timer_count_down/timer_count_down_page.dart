import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:project_examples/file_headers.dart';

class TimerCountDownPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const TimerCountDownPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => TimerCountDownPageState();
}

class TimerCountDownPageState extends NormalStatefulWidgetState<TimerCountDownPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Countdown(
        seconds: 10,
        build: (context, value) => WidgetsFactory.text(
          value == 0 ? '完成' : value.toInt().toString(),
          color: Util.randomOpaqueColor,
          fontSize: 100,
          fontWeight: FontWeight.w300,
        ),
        onFinished: () => appPrint('onFinished'),
      ),
    );
  }
}
