import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/route/getx_route_config.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class ProjectUsePage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const ProjectUsePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ProjectUsePageState();
}

class ProjectUsePageState extends NormalStatefulWidgetState<ProjectUsePage> with WidgetEventCallbackMixin {
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
            const CartItemModel(title: 'SliverSections的使用', route: RouteConfig.sliverSectionsPage),
            const CartItemModel(title: 'SliverRefreshWidget', route: RouteConfig.sliverRefreshWidgetPage),
            const CartItemModel(title: 'InformationView', route: RouteConfig.informationViewPage),
            const CartItemModel(title: 'ToastWidget', route: RouteConfig.toastWidgetPage),
          ],
          builder: (c, i, d) => CartItemWidget(model: d, callback: widgetEventCallback),
        ).buildWidget(),
      ],
    );
  }

  @override
  void widgetEventCallback(BuildContext? context, WidgetEventItem eventItem) {
    if (eventItem.data is CartItemModel) Get.toNamed(eventItem.data.route!, arguments: eventItem.data);
  }
}
