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
          padding: const EdgeInsets.only(bottom: 49),
          items: [
            const MenuItemModel(title: 'ScreenUtil', pageRouteEnum: PageRouteEnum.screenUtilPage),
            const MenuItemModel(title: 'CarouselSlider', pageRouteEnum: PageRouteEnum.carouselSliderPage),
            const MenuItemModel(title: 'FlutterStaggeredAnimations', pageRouteEnum: PageRouteEnum.flutterStaggeredAnimationsPage),
            const MenuItemModel(title: 'HTML.toTextSpan', pageRouteEnum: PageRouteEnum.htmlToTextSpanPage),
            const MenuItemModel(title: 'Loading Animations', pageRouteEnum: PageRouteEnum.loadingAnimationsPage),
            const MenuItemModel(title: 'Shimmer', pageRouteEnum: PageRouteEnum.shimmerPage),
            const MenuItemModel(title: 'Wave', pageRouteEnum: PageRouteEnum.wavePage),
            const MenuItemModel(title: 'SlidingUpPanel', pageRouteEnum: PageRouteEnum.slidingUpPanelPage),
            const MenuItemModel(title: 'Marquee', pageRouteEnum: PageRouteEnum.marqueePage),
            const MenuItemModel(title: 'Lottie', pageRouteEnum: PageRouteEnum.lottiePage),
            const MenuItemModel(title: 'Expandable', pageRouteEnum: PageRouteEnum.expandablePage),
            const MenuItemModel(title: 'DottedBorder', pageRouteEnum: PageRouteEnum.dottedBorderPage),
            const MenuItemModel(title: 'DottedLine', pageRouteEnum: PageRouteEnum.dottedLinePage),
            const MenuItemModel(title: 'ConfettiWidget', pageRouteEnum: PageRouteEnum.confettiWidgetPage),
            const MenuItemModel(title: 'SmoothPageIndicator', pageRouteEnum: PageRouteEnum.smoothPageIndicatorPage),
            const MenuItemModel(title: 'StaggeredGridView', pageRouteEnum: PageRouteEnum.flutterStaggeredGridViewPage),
            const MenuItemModel(title: 'LineIcons', pageRouteEnum: PageRouteEnum.lineIconsPage),
            const MenuItemModel(title: 'ReadMore', pageRouteEnum: PageRouteEnum.readMorePage),
            const MenuItemModel(title: 'TimerCountDown', pageRouteEnum: PageRouteEnum.timerCountDownPage),
            const MenuItemModel(title: 'CachedNetworkImage', pageRouteEnum: PageRouteEnum.cachedNetworkImagePage),
            const MenuItemModel(title: 'Scratcher', pageRouteEnum: PageRouteEnum.scratcherPage),
            const MenuItemModel(title: 'FlipCard', pageRouteEnum: PageRouteEnum.flipCardPage),
            const MenuItemModel(title: 'SnappingSheet', pageRouteEnum: PageRouteEnum.snappingSheetPage),
            const MenuItemModel(title: 'FlutterAnimatedButton', pageRouteEnum: PageRouteEnum.flutterAnimatedButtonPage),
            const MenuItemModel(title: 'LiquidProgressIndicator', pageRouteEnum: PageRouteEnum.liquidProgressIndicatorPage),
          ],
          builder: (c, i, d) => MenuItemWidget(model: d, callback: widgetEventCallback),
        ).buildWidget(),
      ],
    );
  }

  @override
  void widgetEventCallback(BuildContext? context, WidgetEventItem eventItem) {
    if (eventItem.data is MenuItemModel) {
      MenuItemModel item = eventItem.data;
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
