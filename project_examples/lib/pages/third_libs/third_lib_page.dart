import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/pages/base/normal_stateless_widget.dart';
import 'package:project_examples/route/route_config.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class ThirdLibPage extends NormalStatelessWidget with WidgetEventCallbackMixin {
  ThirdLibPage({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
      );

  @override
  Widget backgroundWidget(BuildContext context) => Container(color: Colors.white);

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverListSection(
          items: [
            CartItemModel(title: 'HTML.toTextSpan', route: RouteConfig.htmlToTextSpanPage),
            CartItemModel(title: 'Loading Animations', route: RouteConfig.loadingAnimationsPage),
            CartItemModel(title: 'Shimmer', route: RouteConfig.shimmerPage),
            CartItemModel(title: 'StaggeredGridView', route: RouteConfig.staggeredGridViewPage),
            CartItemModel(title: 'LineIcons', route: RouteConfig.lineIconsPage),
            CartItemModel(title: 'ReadMore', route: RouteConfig.readMorePage),
            CartItemModel(title: 'TimerCountDown', route: RouteConfig.timerCountDownPage),
            CartItemModel(title: 'CachedNetworkImage', route: RouteConfig.cachedNetworkImagePage),
            CartItemModel(title: 'Scratcher', route: RouteConfig.scratcherPage),
            CartItemModel(title: 'FlipCard', route: RouteConfig.flipCardPage),
            CartItemModel(title: 'SnappingSheet', route: RouteConfig.snappingSheetPage),
            CartItemModel(title: 'LiquidProgressIndicator', route: RouteConfig.liquidProgressIndicatorPage),
          ],
          builder: (c, i, d) => CartItemWidget(model: d, callback: widgetEventCallback),
        ).buildWidget(),
      ],
    );
  }

  @override
  void widgetEventCallback(BuildContext? context, WidgetEventItem eventItem) {
    if (eventItem.data is CartItemModel) {
      Get.toNamed(eventItem.data.route!, arguments: eventItem.data);
    }
  }
}
