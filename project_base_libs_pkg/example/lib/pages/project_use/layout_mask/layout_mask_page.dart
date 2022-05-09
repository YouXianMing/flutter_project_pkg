import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class LayoutMaskPage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const LayoutMaskPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _LayoutMaskPageState();
}

class _LayoutMaskPageState extends NormalStatefulWidgetState<LayoutMaskPage> {
  final step = 0.obs;
  late Widget layoutMaskWidget;

  final GlobalKey messageKey = GlobalKey();
  final GlobalKey starKey = GlobalKey();
  final GlobalKey titleKey = GlobalKey();
  final GlobalKey textKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    Util.delayedSeconds(0, () {
      layoutMaskWidget = Obx(() {
        late Rect rect;
        switch (step.value % 5) {
          case 0:
            return const SizedBox();
          case 1:
            rect = messageKey.globalPaintBounds!;
            break;
          case 2:
            rect = starKey.globalPaintBounds!;
            break;
          case 3:
            rect = titleKey.globalPaintBounds!;
            break;
          case 4:
            rect = textKey.globalPaintBounds!;
            break;
          default:
            break;
        }

        return LayoutMaskWidget(
          backgroundColor: Colors.black.withOpacity(0.2),
          masks: [
            Positioned(
              left: rect.left - 10,
              top: rect.top - 10,
              child: Container(
                width: rect.width + 20,
                height: rect.height + 20,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.black),
              ),
            ),
          ],
        ).addTapEvent(() => step.value += 1);
      });

      outerStackContainer.insertWidget(layoutMaskWidget);
    });
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''),
        trailingWidgets: [
          OpacityButtonWidget(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            onTap: () => step.value += 1,
            child: WidgetsFactory.text('点击我', color: Colors.blue),
          ),
        ],
      );

  @override
  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.message, key: messageKey).addPaddingOnly(bottom: 20),
        Icon(Icons.star, key: starKey).addPaddingOnly(bottom: 40),
        Icon(Icons.title, key: titleKey, size: 60).addPaddingOnly(bottom: 20),
        WidgetsFactory.text('可以用作用户引导', key: textKey),
      ],
    ).addPadding(const EdgeInsets.all(30));
  }
}
