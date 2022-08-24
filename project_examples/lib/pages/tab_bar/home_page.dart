import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/route_style.dart';
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
              const CartItemModel(title: '异步编程', pageRouteEnum: PageRouteEnum.asyncKnowledgePage),
              const CartItemModel(title: '项目用库', pageRouteEnum: PageRouteEnum.projectUsePage),
              const CartItemModel(title: '第三方库', pageRouteEnum: PageRouteEnum.thirdLibPage),
              const CartItemModel(title: '动画', pageRouteEnum: PageRouteEnum.animationListPage),
            ],
            builder: (c, i, d) => CartItemWidget(model: d, callback: widgetEventCallback),
          ),
        ],
      ),
    );
  }

  @override
  void widgetEventCallback(BuildContext? context, WidgetEventItem eventItem) {
    if (eventItem.data is CartItemModel) {
      CartItemModel item = eventItem.data;
      switch (appCurrentRouteStyle) {
        case RouteStyle.getxStyle:
          Get.toNamed(item.pageRouteEnum.routeName, arguments: eventItem.data);
          break;
        case RouteStyle.enumStyle:
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
