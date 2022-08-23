import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class SliverRefreshWidgetPage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const SliverRefreshWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => SliverRefreshWidgetPageState();
}

class SliverRefreshWidgetPageState extends NormalStatefulWidgetState<SliverRefreshWidgetPage> {
  final SliversRefreshWidget refreshWidget = SliversRefreshWidget(loadMoreFooterWidgetAddSafeBottom: true);
  final SliverWaterfallFlowSection itemsSection = SliverWaterfallFlowSection();

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
      );

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
  Widget body(BuildContext context) {
    return refreshWidget;
  }

  @override
  Widget firstTimeLoadingWidgetStartLoading(BuildContext context) {
    return firstTimeLoadingWidget.listenFuture(() => Future.delayed(const Duration(seconds: 1), () {})).onSuccess((d) {
      itemsSectionConfig();
      itemsSection.items!.addAll(randomItems(30));
      refreshWidget.sliversSections.add(itemsSection);
      refreshWidget.setOnLoadBlock(onLoad).setOnRefreshBlock(onRefresh);
      refreshWidget.update(itemsDidFillRefreshWidget: (didFill) => refreshWidget.setLoadMoreEnable(didFill == true));
    });
  }

  List<ItemData> randomItems(int count) {
    List<ItemData> datas = [];
    for (int i = 0; i < count; i++) {
      datas.add(ItemData(100 + Util.randomDouble(max: 50), data: Util.randomWordPairAsCamelCase));
    }

    return datas;
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
