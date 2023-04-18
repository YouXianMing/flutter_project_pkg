import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_examples/base/widget_callback_mixin.dart';

class HomePage extends NormalStatefulWidget {
  @override
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
              const MenuItemModel(title: '第三方库', pageRouteEnum: PageRouteEnum.thirdLibPage),
              const MenuItemModel(title: '项目用库', pageRouteEnum: PageRouteEnum.projectUsePage),
              const MenuItemModel(title: '动画', pageRouteEnum: PageRouteEnum.animationListPage),
              const MenuItemModel(title: '异步编程', pageRouteEnum: PageRouteEnum.asyncKnowledgePage),
            ],
            builder: (c, i, d) => MenuItemWidget(model: d, callback: widgetEventCallback),
          ),
        ],
      ),
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
