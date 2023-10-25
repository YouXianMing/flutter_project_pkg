import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class LayoutMaskWidgetPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const LayoutMaskWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => LayoutMaskWidgetPageState();
}

class LayoutMaskWidgetPageState extends NormalStatefulWidgetState<LayoutMaskWidgetPage> {
  final _step = 0.obs;
  late Widget _layoutMaskWidget;
  final GlobalKey _messageKey = GlobalKey();
  final GlobalKey _starKey = GlobalKey();
  final GlobalKey _titleKey = GlobalKey();
  final GlobalKey _textKey = GlobalKey();

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
        trailingWidgets: [
          OpacityButtonWidget(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            onTap: () => _step.value += 1,
            child: WidgetsFactory.text('点击我', color: Colors.blue),
          ),
        ],
      );

  @override
  void initState() {
    super.initState();

    Util.delayedSeconds(0, () {
      _layoutMaskWidget = Obx(() {
        late Rect rect;
        switch (_step.value % 5) {
          case 0:
            return const SizedBox();
          case 1:
            rect = _messageKey.globalPaintBounds!;
            break;
          case 2:
            rect = _starKey.globalPaintBounds!;
            break;
          case 3:
            rect = _titleKey.globalPaintBounds!;
            break;
          case 4:
            rect = _textKey.globalPaintBounds!;
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
        ).addTapEvent(() => _step.value += 1);
      });

      outerStackContainer.insertWidget(_layoutMaskWidget);
    });
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.message, key: _messageKey).addPaddingOnly(bottom: 20),
        Icon(Icons.star, key: _starKey).addPaddingOnly(bottom: 40),
        Icon(Icons.title, key: _titleKey, size: 60).addPaddingOnly(bottom: 20),
        WidgetsFactory.text('可以用作用户引导', key: _textKey),
      ],
    ).addPadding(const EdgeInsets.all(30));
  }
}
