import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_examples/widgets/sliding_up_panel_widget.dart';
import 'package:project_examples/file_headers.dart';

class SlidingUpPanelPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const SlidingUpPanelPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => SlidingUpPanelPageState();
}

class SlidingUpPanelPageState extends NormalStatefulWidgetState<SlidingUpPanelPage> {
  final controller = SlidingUpPanelWidgetController();

  @override
  void initState() {
    super.initState();
    controller.data = _randomData();
  }

  List<String> _randomData() {
    List<String> items = [];
    var count = Util.randomInt(max: 16, min: 8);
    for (int i = 0; i < count; i++) {
      items.add(Util.randomWordPairAsPascalCase);
    }

    return items;
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: OpacityButtonWidget(
            onTap: () => controller.update(data: _randomData()),
            child: WidgetsFactory.text('更新数据', fontSize: 22, color: Colors.white).addContainerBorderRadius(
              radius: 6,
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            ),
          ),
        ),
        SlidingUpPanelWidget(
          controller: controller,
          fixedWidth: Get.width,
          minHeight: MediaQuery.of(context).padding.bottom + 70,
          builder: (dynamic data, bool onPanelOpened, SlidingUpPanelWidgetController controller) => BottomPanelItemWidget(
            onPanelOpened: onPanelOpened,
            controller: controller,
            data: data,
          ),
        ),
      ],
    );
  }
}

class BottomPanelItemWidget extends StatelessWidget {
  final dynamic data;
  final bool onPanelOpened;
  final SlidingUpPanelWidgetController controller;

  const BottomPanelItemWidget({
    super.key,
    this.data,
    required this.onPanelOpened,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    List<String> items = data;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
        color: Colors.indigoAccent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.toc, color: Colors.white).addPaddingOnly(right: 5),
              WidgetsFactory.text('Total ${items.length}', color: Colors.white, fontSize: 20),
            ],
          ).addPaddingOnly(bottom: 20),
          WidgetsFactory.scrollViewBuilder(
            build: ListViewBuilderConfig(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              items: items,
              builder: (c, i, d) => WidgetsFactory.text(d, color: Colors.white, fontSize: 18).addPaddingOnly(bottom: 14),
            ),
          ),
        ],
      ),
    );
  }
}
