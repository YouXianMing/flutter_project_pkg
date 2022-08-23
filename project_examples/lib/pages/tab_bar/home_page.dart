import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/route/getx_route_config.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class HomePage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const HomePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => HomePageState();
}

class HomePageState extends NormalStatefulWidgetState<HomePage> with WidgetEventCallbackMixin {
  @override
  void widgetEventCallback(BuildContext? context, WidgetEventItem eventItem) {
    if (eventItem.data is CartItemModel) {
      Get.toNamed(eventItem.data.route!, arguments: eventItem.data);
    }
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget backgroundWidget(BuildContext context) => Container(color: Colors.white);

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverListSection.builderTypeWidget(
            items: [
              const CartItemModel(title: '异步编程', route: RouteConfig.asyncKnowledgePage),
              const CartItemModel(title: '项目用库', route: RouteConfig.projectUsePage),
              const CartItemModel(title: '第三方库', route: RouteConfig.thirdLibPage),
              const CartItemModel(title: '动画', route: RouteConfig.animationListPage),
            ],
            builder: (c, i, d) => CartItemWidget(model: d, callback: widgetEventCallback),
          ),
        ],
      ),
    );
  }
}
