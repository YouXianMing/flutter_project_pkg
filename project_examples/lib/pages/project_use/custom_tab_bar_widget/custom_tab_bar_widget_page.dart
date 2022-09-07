import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';

class CustomTabBarWidgetPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const CustomTabBarWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => CustomTabBarWidgetPageState();
}

class CustomTabBarWidgetPageState extends NormalStatefulWidgetState<CustomTabBarWidgetPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return CustomTabBarWidget(
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: Colors.black.withOpacity(0.3),
      labelColor: Colors.blue,
      indicatorWeight: 3,
      appBarHeight: 35,
      tabBarItems: [
        CustomTabBarItem(tab: const Tab(text: 'Video'), widget: Container(color: Util.randomColor.withOpacity(0.3))),
        CustomTabBarItem(tab: const Tab(text: 'Media'), widget: Container(color: Util.randomColor.withOpacity(0.3))),
      ],
      onTap: (index) => appPrint(index),
    );
  }
}
