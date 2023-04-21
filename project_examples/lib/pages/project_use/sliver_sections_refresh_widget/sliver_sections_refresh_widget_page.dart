import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class SliverSectionsRefreshWidgetPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const SliverSectionsRefreshWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => SliverSectionsRefreshWidgetPageState();
}

class SliverSectionsRefreshWidgetPageState extends NormalStatefulWidgetState<SliverSectionsRefreshWidgetPage> {
  final SliverWaterfallFlowSection itemsSection = SliverWaterfallFlowSection();
  final controller = SliverSectionsRefreshWidgetController(loadMoreFooterWidgetAddSafeBottom: true);

  @override
  void initState() {
    super.initState();

    // 配置刷新回调,加载回调
    controller.setPullRefreshCallback(
      (refreshController) {
        // 模拟刷新的网络请求
        Future.delayed(const Duration(seconds: 1), () {
          if (Util.randomPercent > 0.2) {
            itemsSection.items!.clear();
            itemsSection.items!.addAll(randomItems(20));
            refreshController.endRefresh();
          } else {
            refreshController.endRefresh(failed: true);
          }
        });
      },
    ).setLoadMoreCallback(
      (refreshController) {
        // 模拟加载更多的网络请求
        Future.delayed(const Duration(seconds: 1), () {
          if (Util.randomPercent > 0.2) {
            itemsSection.items!.addAll(randomItems(20));
            refreshController.endLoadData();
          } else {
            refreshController.endLoadData(failed: true);
          }
        });
      },
    );
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) => SliverSectionsRefreshWidget(controller: controller);

  @override
  Widget firstTimeLoadingWidgetStartLoading(BuildContext context) {
    return firstTimeLoadingWidget.listenFuture(() => Future.delayed(const Duration(seconds: 1), () {})).onSuccess((d) {
      itemsSectionConfig();
      itemsSection.items!.addAll(randomItems(30));
      controller.sliverSections.add(itemsSection);
      controller.updateWidget();
    });
  }

  List<ItemData> randomItems(int count) {
    List<ItemData> data = [];
    for (int i = 0; i < count; i++) {
      data.add(ItemData(100 + Util.randomDouble(max: 50), data: Util.randomWordPairAsCamelCase));
    }

    return data;
  }

  /// 对section进行一些配置
  void itemsSectionConfig() {
    itemsSection.padding = const EdgeInsets.all(10);
    itemsSection.crossAxisCount = 3;
    itemsSection.mainAxisSpacing = 10;
    itemsSection.crossAxisSpacing = 10;
    itemsSection.builder = (c, i, d) {
      ItemData data = d as ItemData;
      return Container(height: data.height, color: Colors.white, alignment: Alignment.center, child: Text(data.data));
    };
  }
}

class ItemData {
  String data;
  final double height;

  ItemData(this.height, {required this.data});
}
