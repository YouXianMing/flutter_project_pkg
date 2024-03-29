import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class MaybePopPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const MaybePopPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => MaybePopPageState();
}

class MaybePopPageState extends NormalStatefulWidgetState<MaybePopPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          showInformationView();
          Util.delayedMilliseconds(800, () => showInformationView());
          Util.delayedMilliseconds(1600, () => showInformationView());
        },
        child: Text('点击我'.tr),
      ),
    );
  }

  void showInformationView() {
    InformationView(
      type: AnimatedWidgetType.sheetView,
      config: AnimatedSheetViewConfig(backgroundColor: Colors.black.withAlpha(75)),
    ).managerMaybePopEvent().inOverlay(context).setWidgetBuilder((v) {
      return Column(
        children: [
          Flexible(flex: 2, child: Container(color: Colors.transparent).addTapEvent(() => v.hide())),
          Flexible(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // 顶部标题
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        WidgetsFactory.text('Sheet', color: Colors.black, fontSize: 14).addDefaultTextStyle(),
                        Positioned(right: 5, child: const Icon(Icons.close).addTapEvent(() => v.hide())),
                      ],
                    ),
                  ),
                  // 线条
                  Container(height: 1, color: Colors.grey.withOpacity(0.2)),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverListSection.builderTypeWidget(
                          items: [
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                            Util.randomWordPairAsCamelCase,
                          ],
                          builder: (c, i, d) => WidgetsFactory.text(d, color: Util.randomOpaqueColor).addDefaultTextStyle(),
                        ),
                        SliverBoxAdapterSection.widget(builder: (v) => const SafeAreaPaddingWidget(type: SafeAreaPadding.bottom)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }).show();
  }
}
