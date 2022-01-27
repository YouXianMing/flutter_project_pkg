import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class SliverRefreshWidgetPage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const SliverRefreshWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _SliverRefreshWidgetPageState();
}

class _SliverRefreshWidgetPageState extends NormalStatefulWidgetState<SliverRefreshWidgetPage> {
  final SliversRefreshWidget refreshWidget = SliversRefreshWidget(loadMoreFooterWidgetAddSafeBottom: true);
  final SliverWaterfallFlowSection itemsSection = SliverWaterfallFlowSection();

  @override
  void initState() {
    super.initState();
    itemsSectionConfig();
    refreshWidget.sliversSections.add(itemsSection);
    refreshWidget.setOnLoadBlock(onLoad).setOnRefreshBlock(onRefresh);
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) =>
      NormalAppBar(context: context, title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''));

  void onLoad(SliversRefreshWidget widget) {
    Future.delayed(const Duration(seconds: 1), () {
      if (Util.randomPercent > 0.2) {
        itemsSection.items!.addAll(randomItems(20));
        widget.endLoadData();
      } else {
        widget.endLoadData(failed: true);
      }
    });
  }

  void onRefresh(SliversRefreshWidget widget) {
    Future.delayed(const Duration(seconds: 1), () {
      if (Util.randomPercent > 0.2) {
        itemsSection.items!.clear();
        itemsSection.items!.addAll(randomItems(20));
        widget.endRefresh();
      } else {
        widget.endRefresh(failed: true);
      }
    });
  }

  @override
  Widget body(BuildContext context) => refreshWidget;

  @override
  Widget firstTimeLoadingWidgetStartLoading(BuildContext context) {
    return firstTimeLoadingWidget.listenFuture(() => Future.delayed(const Duration(seconds: 1), () {})).onSuccess((d) {
      itemsSection.items!.addAll(randomItems(30));
      refreshWidget.update(itemsDidFillRefreshWidget: (didFill) => refreshWidget.setLoadMoreEnable(didFill == true));
    });
  }

  List<ItemData> randomItems(int count) {
    List<ItemData> items = [];
    for (int i = 0; i < count; i++) {
      items.add(ItemData(100 + Util.randomDouble(max: 50), data: Util.randomWordPairAsCamelCase));
    }

    return items;
  }

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
