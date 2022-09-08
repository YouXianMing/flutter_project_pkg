import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class TabBarPage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const TabBarPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _TabBarPageState();
}

class _TabBarPageState extends NormalStatefulWidgetState<TabBarPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return NormalAppBar(context: context, title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''));
  }

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
