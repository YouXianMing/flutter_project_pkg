import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/base_stateful_widget.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/base/widget_callback_mixin.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/sliver_list/sliver_list_section.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_examples/app_route_style.dart';

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
            const MenuItemModel(title: '动画基本使用', pageRouteEnum: PageRouteEnum.baseAnimatedPage),
            const MenuItemModel(title: '组合动画', pageRouteEnum: PageRouteEnum.groupAnimationPage),
            const MenuItemModel(title: '分段动画', pageRouteEnum: PageRouteEnum.tweenSequenceAnimationPage),
            const MenuItemModel(title: 'AnimatedWidget使用', pageRouteEnum: PageRouteEnum.animatedWidgetPage),
            const MenuItemModel(title: 'AnimationsManager的使用', pageRouteEnum: PageRouteEnum.animationsManagerPage),
            const MenuItemModel(title: 'AnimationsManager的重复使用', pageRouteEnum: PageRouteEnum.animationsManagerRandomPage),
            const MenuItemModel(title: 'AnimationsManager的Curves', pageRouteEnum: PageRouteEnum.animationsManagerCurvesPage),
            const MenuItemModel(title: 'AnimationsManager与Interval配合使用', pageRouteEnum: PageRouteEnum.animationsManagerIntervalPage),
            const MenuItemModel(title: 'AnimationsManager与Sequence配合使用', pageRouteEnum: PageRouteEnum.animationsManagerSequencePage),
            const MenuItemModel(title: '添加购物车动画', pageRouteEnum: PageRouteEnum.goodsAddToCartPage),
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
