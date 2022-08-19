import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/pages/base/normal_stateful_widget.dart';
import 'package:project_examples/route/getx_route_config.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class ThirdLibPage extends NormalStatefulWidget {
  const ThirdLibPage({Key? key}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ThirdLibPageState();
}

class ThirdLibPageState extends NormalStatefulWidgetState<ThirdLibPage> with WidgetEventCallbackMixin {
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
            const CartItemModel(title: 'HTML.toTextSpan', route: RouteConfig.htmlToTextSpanPage),
            const CartItemModel(title: 'Loading Animations', route: RouteConfig.loadingAnimationsPage),
            const CartItemModel(title: 'Shimmer', route: RouteConfig.shimmerPage),
            const CartItemModel(title: 'StaggeredGridView', route: RouteConfig.staggeredGridViewPage),
            const CartItemModel(title: 'LineIcons', route: RouteConfig.lineIconsPage),
            const CartItemModel(title: 'ReadMore', route: RouteConfig.readMorePage),
            const CartItemModel(title: 'TimerCountDown', route: RouteConfig.timerCountDownPage),
            const CartItemModel(title: 'CachedNetworkImage', route: RouteConfig.cachedNetworkImagePage),
            const CartItemModel(title: 'Scratcher', route: RouteConfig.scratcherPage),
            const CartItemModel(title: 'FlipCard', route: RouteConfig.flipCardPage),
            const CartItemModel(title: 'SnappingSheet', route: RouteConfig.snappingSheetPage),
            const CartItemModel(title: 'FlutterAnimatedButton', route: RouteConfig.flutterAnimatedButtonPage),
            const CartItemModel(title: 'LiquidProgressIndicator', route: RouteConfig.liquidProgressIndicatorPage),
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
