import 'package:flutter/material.dart';
import 'base_app_bar.dart';

/// 没有高度的AppBar,适用于有TabBar但是又不需要AppBar的地方,TabBar必须要有Appbar才可以点击Tab的时候页面切换,否则点击不切换
class TabBarNoneHeightAppBar extends BaseAppBar {
  const TabBarNoneHeightAppBar({Key? key}) : super(key: key);

  @override
  bool get addSafeAreaTop => false;

  @override
  double get preferredSizeHeight => 0;

  @override
  Widget? buildContentWidget(BuildContext context) => null;

  @override
  Widget? buildLeadingWidget(BuildContext context) => null;

  @override
  Widget? buildTrailingWidget(BuildContext context) => null;

  @override
  Widget buildRootWidget(BuildContext context) => const SizedBox(height: 0);
}

class CustomTabBarItem {
  /// tab(最好是Tab,因为TabBar中的labelColor与labelStyle等参数设置只会对Tab的widget生效)
  Widget tab;

  /// TabBarView上的widget
  Widget widget;

  CustomTabBarItem({required this.tab, required this.widget});
}

class BaseCustomTabBarAccess {
  const BaseCustomTabBarAccess();
  Widget accessTabBar(TabBar tabBar) => tabBar;
}

class BaseCustomTabBarViewAccess {
  const BaseCustomTabBarViewAccess();
  Widget accessTabBarView(TabBarView tabBarView) => Column(children: [Expanded(child: tabBarView)]);
}

class CustomTabBarWidget extends StatefulWidget {
  final List<CustomTabBarItem> tabBarItems;

  /// 背景色
  final Color? backgroundColor;

  /// 对TabBar控件的布局进行一定的处理
  final BaseCustomTabBarAccess tabBarAccess;

  /// 对TabBarView控件的布局进行一定的处理
  final BaseCustomTabBarViewAccess tabBarViewAccess;

  /// wantKeepAlive,默认为true
  final bool wantKeepAlive;

  /// 初始化时的index,默认为0
  final int initialIndex;

  /// 顶部Tab的高度,默认为kToolbarHeight
  final double appBarHeight;

  /// tab的排列方式,如果为false,则为均分;如果为true,则按照tab的实际大小排列
  final bool isScrollable;

  /// label的padding
  final EdgeInsets? labelPadding;

  /// 设置选中时的字体颜色，tabs里面的字体样式优先级最高
  final Color? labelColor;

  /// 设置选中时的字体样式，tabs里面的字体样式优先级最高
  final TextStyle? labelStyle;

  /// 设置未选中时的字体颜色，tabs里面的字体样式优先级最高
  final Color? unselectedLabelColor;

  /// 设置未选中时的字体样式，tabs里面的字体样式优先级最高
  final TextStyle? unselectedLabelStyle;

  /// 下划线样式,可以设置BoxDecoration对其进行修改
  final Decoration? indicator;

  /// 下划线的padding
  final EdgeInsets indicatorPadding;

  /// 下划线高度
  final double indicatorWeight;

  /// 下划线颜色
  final Color? indicatorColor;

  /// 选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
  final TabBarIndicatorSize? indicatorSize;

  /// Tab点击的事件回调(在没有AppBar的时候,onTap会失效,点击Tab也没有反应,此时需要使用没有高度的AppBar,如上面提供的TabBarNoHeightAppBar)
  final ValueChanged<int>? onTap;

  const CustomTabBarWidget({
    Key? key,
    required this.tabBarItems,
    this.backgroundColor,
    this.tabBarAccess = const BaseCustomTabBarAccess(),
    this.tabBarViewAccess = const BaseCustomTabBarViewAccess(),
    this.wantKeepAlive = true,
    this.initialIndex = 0,
    this.appBarHeight = kToolbarHeight,
    this.isScrollable = false,
    this.labelPadding,
    this.labelColor,
    this.labelStyle,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.indicator,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicatorWeight = 2.0,
    this.indicatorColor,
    this.indicatorSize,
    this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomTabBarWidgetState();
}

class CustomTabBarWidgetState extends State<CustomTabBarWidget> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabBarItems.length, vsync: this, initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  List<Widget> get tabs {
    List<Widget> list = [];
    for (var value in widget.tabBarItems) {
      list.add(value.tab);
    }
    return list;
  }

  List<Widget> get tabBarViewWidgets {
    List<Widget> list = [];
    for (var value in widget.tabBarItems) {
      list.add(value.widget);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, widget.appBarHeight),
        child: widget.tabBarAccess.accessTabBar(
          TabBar(
            tabs: tabs,
            controller: tabController,
            isScrollable: widget.isScrollable,
            indicator: widget.indicator,
            indicatorPadding: widget.indicatorPadding,
            indicatorColor: widget.indicatorColor,
            indicatorSize: widget.indicatorSize,
            indicatorWeight: widget.indicatorWeight,
            labelPadding: widget.labelPadding,
            labelColor: widget.labelColor,
            labelStyle: widget.labelStyle,
            unselectedLabelColor: widget.unselectedLabelColor,
            unselectedLabelStyle: widget.unselectedLabelStyle,
            onTap: widget.onTap,
          ),
        ),
      ),
      body: widget.tabBarViewAccess.accessTabBarView(
        TabBarView(controller: tabController, children: tabBarViewWidgets),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
