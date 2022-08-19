import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/base_stateful_widget.dart';
import 'package:project_examples/pages/base/normal_stateful_widget.dart';
import 'package:project_examples/route/getx_route_config.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/base/others/sliver_section/sliver_list/sliver_list_section.dart';
import 'package:project_base_libs_pkg/base/widgets/widget_callback_mixin.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class AnimationListPage extends NormalStatefulWidget {
  const AnimationListPage({Key? key}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AnimationListPageState();
}

class AnimationListPageState extends NormalStatefulWidgetState<AnimationListPage> with WidgetEventCallbackMixin {
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
            const CartItemModel(title: '动画基本使用', route: RouteConfig.baseAnimatedPage),
            const CartItemModel(title: '组合动画', route: RouteConfig.groupAnimationPage),
            const CartItemModel(title: '分段动画', route: RouteConfig.tweenSequenceAnimationPage),
            const CartItemModel(title: 'AnimatedWidget使用', route: RouteConfig.animatedWidgetPage),
            const CartItemModel(title: 'AnimationsManager的使用', route: RouteConfig.animationsManagerPage),
            const CartItemModel(title: 'AnimationsManager的重复使用', route: RouteConfig.animationsManagerRandomPage),
            const CartItemModel(title: 'AnimationsManager的Curves', route: RouteConfig.animationsManagerCurvesPage),
            const CartItemModel(title: 'AnimationsManager与Interval配合使用', route: RouteConfig.animationsManagerIntervalPage),
            const CartItemModel(title: 'AnimationsManager与Sequence配合使用', route: RouteConfig.animationsManagerSequencePage),
            const CartItemModel(title: '添加购物车动画', route: RouteConfig.goodsAddToCartPage),
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
