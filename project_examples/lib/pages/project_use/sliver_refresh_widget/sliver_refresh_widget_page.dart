import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class SliverRefreshWidgetPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const SliverRefreshWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => SliverRefreshWidgetPageState();
}

class SliverRefreshWidgetPageState extends NormalStatefulWidgetState<SliverRefreshWidgetPage> {
  final SliversRefreshWidget _refreshWidget = SliversRefreshWidget(loadMoreFooterWidgetAddSafeBottom: true);
  final SliverWaterfallFlowSection _itemsSection = SliverWaterfallFlowSection();

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  void onLoad(SliversRefreshWidget widget) {
    Future.delayed(const Duration(seconds: 1), () {
      if (Util.randomPercent > 0.2) {
        _itemsSection.items!.addAll(randomItems(20));
        widget.endLoadData();
      } else {
        widget.endLoadData(failed: true);
      }
    });
  }

  void onRefresh(SliversRefreshWidget widget) {
    Future.delayed(const Duration(seconds: 1), () {
      if (Util.randomPercent > 0.2) {
        _itemsSection.items!.clear();
        _itemsSection.items!.addAll(randomItems(20));
        widget.endRefresh();
      } else {
        widget.endRefresh(failed: true);
      }
    });
  }

  @override
  Widget body(BuildContext context) => _refreshWidget;

  @override
  Widget firstTimeLoadingWidgetStartLoading(BuildContext context) {
    return firstTimeLoadingWidget.listenFuture(() => Future.delayed(const Duration(seconds: 1), () {})).onSuccess((d) {
      itemsSectionConfig();
      _itemsSection.items!.addAll(randomItems(30));
      _refreshWidget.sliversSections.add(_itemsSection);
      _refreshWidget.setOnLoadBlock(onLoad).setOnRefreshBlock(onRefresh);
      _refreshWidget.update(itemsDidFillRefreshWidget: (didFill) => _refreshWidget.setLoadMoreEnable(didFill == true));
    });
  }

  List<ItemData> randomItems(int count) {
    List<ItemData> data = [];
    for (int i = 0; i < count; i++) {
      data.add(ItemData(100 + Util.randomDouble(max: 50), data: Util.randomWordPairAsCamelCase));
    }

    return data;
  }

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
