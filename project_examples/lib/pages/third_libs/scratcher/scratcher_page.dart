import 'package:flutter/material.dart';
import 'package:project_examples/pages/base/normal_stateful_widget.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:scratcher/widgets.dart';

class ScratcherPage extends NormalStatefulWidget {
  const ScratcherPage({Key? key}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ScratcherPageState();
}

class ScratcherPageState extends NormalStatefulWidgetState<ScratcherPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
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
              TextButton(onPressed: () => scratchKey.currentState!.reset(), child: const Text('重置')),
              TextButton(
                  onPressed: () => scratchKey.currentState!.reveal(duration: const Duration(milliseconds: 500)), child: const Text('刮开')),
            ],
          ),
        ],
      ),
    );
  }
}
