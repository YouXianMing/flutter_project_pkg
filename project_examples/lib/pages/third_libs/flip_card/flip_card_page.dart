import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class FlipCardPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const FlipCardPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => FlipCardPageState();
}

class FlipCardPageState extends NormalStatefulWidgetState<FlipCardPage> {
  late FlipCardController _controller;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlipCard(
            controller: _controller,
            direction: FlipDirection.HORIZONTAL,
            front: Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              color: Colors.blue,
              child: WidgetsFactory.text('正面'.tr, fontSize: 20, color: Colors.white),
            ),
            back: Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              color: Colors.red,
              child: WidgetsFactory.text('反面'.tr, fontSize: 20, color: Colors.white),
            ),
          ),
          TextButton(onPressed: () => _controller.toggleCard(), child: WidgetsFactory.text('翻转'.tr)),
          TextButton(
              onPressed: () =>
                  _controller.skew(Util.randomPercent, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic),
              child: WidgetsFactory.text('随机角度'.tr)),
          TextButton(
              onPressed: () => _controller.hint(duration: const Duration(milliseconds: 1100), total: const Duration(milliseconds: 1000)),
              child: WidgetsFactory.text('暗示(该控件可以翻转)'.tr)),
        ],
      ),
    );
  }
}
