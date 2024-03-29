import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';
import 'package:scratcher/widgets.dart';

class ScratcherPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ScratcherPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ScratcherPageState();
}

class ScratcherPageState extends NormalStatefulWidgetState<ScratcherPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  final scratchKey = GlobalKey<ScratcherState>();

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Scratcher(
            key: scratchKey,
            brushSize: 30,
            threshold: 50,
            color: Colors.grey,
            onChange: (value) => appPrint('Scratch progress: $value%'),
            onThreshold: () => appPrint('Threshold reached, you won!'),
            child: SizedBox(
              width: 300,
              child: Util.image('你中奖啦.png'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () => scratchKey.currentState!.reset(), child: Text('重置'.tr)),
              TextButton(
                  onPressed: () => scratchKey.currentState!.reveal(duration: const Duration(milliseconds: 500)), child: Text('刮开'.tr)),
            ],
          ),
        ],
      ),
    );
  }
}
