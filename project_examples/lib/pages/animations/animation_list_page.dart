import 'package:project_examples/base/widget_callback_mixin.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/sliver_list/sliver_list_section.dart';
import 'package:project_examples/file_headers.dart';

class AnimationListPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const AnimationListPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AnimationListPageState();
}

class AnimationListPageState extends NormalStatefulWidgetState<AnimationListPage> with WidgetEventCallbackMixin {
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
            MenuItemModel(title: '动画基本使用'.tr, pageRouteEnum: PageRouteEnum.baseAnimatedPage),
            MenuItemModel(title: '组合动画'.tr, pageRouteEnum: PageRouteEnum.groupAnimationPage),
            MenuItemModel(title: '分段动画'.tr, pageRouteEnum: PageRouteEnum.tweenSequenceAnimationPage),
            MenuItemModel(title: 'AnimatedWidget使用'.tr, pageRouteEnum: PageRouteEnum.animatedWidgetPage),
            MenuItemModel(title: 'AnimationsManager的使用'.tr, pageRouteEnum: PageRouteEnum.animationsManagerPage),
            MenuItemModel(title: 'AnimationsManager的重复使用'.tr, pageRouteEnum: PageRouteEnum.animationsManagerRandomPage),
            MenuItemModel(title: 'AnimationsManager的Curves'.tr, pageRouteEnum: PageRouteEnum.animationsManagerCurvesPage),
            MenuItemModel(title: 'AnimationsManager与Interval配合使用'.tr, pageRouteEnum: PageRouteEnum.animationsManagerIntervalPage),
            MenuItemModel(title: 'AnimationsManager与Sequence配合使用'.tr, pageRouteEnum: PageRouteEnum.animationsManagerSequencePage),
            MenuItemModel(title: '添加购物车动画'.tr, pageRouteEnum: PageRouteEnum.goodsAddToCartPage),
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
