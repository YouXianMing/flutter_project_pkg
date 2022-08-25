import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_examples/app_route_style.dart';

class ThirdLibPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ThirdLibPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ThirdLibPageState();
}

class ThirdLibPageState extends NormalStatefulWidgetState<ThirdLibPage> with WidgetEventCallbackMixin {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget backgroundWidget(BuildContext context) => Container(color: Colors.white);

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverListSection(
          items: [
            const CartItemModel(title: 'ScreenUtil', pageRouteEnum: PageRouteEnum.screenUtilPage),
            const CartItemModel(title: 'CarouselSlider', pageRouteEnum: PageRouteEnum.carouselSliderPage),
            const CartItemModel(title: 'FlutterStaggeredAnimations', pageRouteEnum: PageRouteEnum.flutterStaggeredAnimationsPage),
            const CartItemModel(title: 'HTML.toTextSpan', pageRouteEnum: PageRouteEnum.htmlToTextSpanPage),
            const CartItemModel(title: 'Loading Animations', pageRouteEnum: PageRouteEnum.loadingAnimationsPage),
            const CartItemModel(title: 'Shimmer', pageRouteEnum: PageRouteEnum.shimmerPage),
            const CartItemModel(title: 'SmoothPageIndicator', pageRouteEnum: PageRouteEnum.smoothPageIndicatorPage),
            const CartItemModel(title: 'StaggeredGridView', pageRouteEnum: PageRouteEnum.flutterStaggeredGridViewPage),
            const CartItemModel(title: 'LineIcons', pageRouteEnum: PageRouteEnum.lineIconsPage),
            const CartItemModel(title: 'ReadMore', pageRouteEnum: PageRouteEnum.readMorePage),
            const CartItemModel(title: 'TimerCountDown', pageRouteEnum: PageRouteEnum.timerCountDownPage),
            const CartItemModel(title: 'CachedNetworkImage', pageRouteEnum: PageRouteEnum.cachedNetworkImagePage),
            const CartItemModel(title: 'Scratcher', pageRouteEnum: PageRouteEnum.scratcherPage),
            const CartItemModel(title: 'FlipCard', pageRouteEnum: PageRouteEnum.flipCardPage),
            const CartItemModel(title: 'SnappingSheet', pageRouteEnum: PageRouteEnum.snappingSheetPage),
            const CartItemModel(title: 'FlutterAnimatedButton', pageRouteEnum: PageRouteEnum.flutterAnimatedButtonPage),
            const CartItemModel(title: 'LiquidProgressIndicator', pageRouteEnum: PageRouteEnum.liquidProgressIndicatorPage),
          ],
          builder: (c, i, d) => CartItemWidget(model: d, callback: widgetEventCallback),
        ).buildWidget(),
      ],
    );
  }

  @override
  void widgetEventCallback(BuildContext? context, WidgetEventItem eventItem) {
    if (eventItem.data is CartItemModel) {
      CartItemModel item = eventItem.data;
      switch (appCurrentRouteStyle) {
        case AppRouteStyle.getxType:
          Get.toNamed(item.pageRouteEnum.routeName, arguments: eventItem.data);
          break;
        case AppRouteStyle.namedRouteType:
          appRouteTo(
            this.context,
            NormalPageInfo(
              pageRoute: item.pageRouteEnum,
              arguments: PageArguments(params: {'title': eventItem.data.title}),
            ),
          );
          break;
      }
    }
  }
}
