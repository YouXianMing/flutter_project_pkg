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
  final SliverWaterfallFlowSection _itemsSection = SliverWaterfallFlowSection();
  final _controller = SliverSectionsRefreshWidgetController(loadMoreFooterWidgetAddSafeBottom: true);

  @override
  void initState() {
    super.initState();

    // 配置刷新回调,加载回调
    _controller.setPullRefreshCallback(
      (refreshController) {
        // 模拟刷新的网络请求
        Future.delayed(const Duration(seconds: 1), () {
          if (Util.randomPercent > 0.2) {
            _itemsSection.items!.clear();
            _itemsSection.items!.addAll(randomItems(20));
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
            _itemsSection.items!.addAll(randomItems(20));
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
  Widget body(BuildContext context) => SliverSectionsRefreshWidget(controller: _controller);

  @override
  Widget firstTimeLoadingWidgetStartLoading(BuildContext context) {
    return firstTimeLoadingWidget.listenFuture(() => Future.delayed(const Duration(seconds: 1), () {})).onSuccess((d) {
      itemsSectionConfig();
      _itemsSection.items!.addAll(randomItems(30));
      _controller.sliverSections.add(_itemsSection);
      _controller.updateWidget();
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
    _itemsSection.padding = const EdgeInsets.all(10);
    _itemsSection.crossAxisCount = 3;
    _itemsSection.mainAxisSpacing = 10;
    _itemsSection.crossAxisSpacing = 10;
    _itemsSection.builder = (c, i, d) {
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
