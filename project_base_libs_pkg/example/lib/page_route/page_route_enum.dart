import 'package:example/pages/project_use/files_scan/files_scan_page.dart';
import 'package:example/pages/project_use/indicator_widget/indicator_widget_page.dart';
import 'package:example/pages/project_use/getx_refresh/getx_refresh_page.dart';
import 'package:example/pages/project_use/information_view/infomation_view_page.dart';
import 'package:example/pages/project_use/maybe_pop/maybe_pop_page.dart';
import 'package:example/pages/project_use/networks/networks_page.dart';
import 'package:example/pages/project_use/reg_exp/reg_exp_page.dart';
import 'package:example/pages/project_use/sliver_refresh_widget/slivers_refresh_widget_page.dart';
import 'package:example/pages/project_use/sliver_sections/sliver_sections_page.dart';
import 'package:example/pages/project_use/sp_val/sp_val_page.dart';
import 'package:example/pages/project_use/status_widget/status_widget_page.dart';
import 'package:example/pages/project_use/tab_bar/tab_bar_page.dart';
import 'package:example/pages/project_use/text_field/text_field_page.dart';
import 'package:example/pages/project_use/toast_widget/toast_widget_page.dart';
import 'package:example/pages/home/home_page.dart';
import 'package:flutter/material.dart';

enum PageRouteEnum {
  home,
  informationView,
  sliverRefreshWidget,
  sliverSections,
  statusWidget,
  toastWidget,
  spVal,
  textField,
  fileScan,
  regExp,
  indicatorWidget,
  getxRefresh,
  maybePop,
  networks,
  tabBar,
}

// pageRouteEnum的准备操作,请放在main里
void pageRouteEnumPrepare() {
  for (var value in PageRouteEnum.values) {
    value._storeValueToMap();
  }
}

// 根据路由名字转化成enum值
PageRouteEnum? pageRouteEnumFromName(String name) => _stringEnumMap[name];

extension PageRouteEnumExtension on PageRouteEnum {
  // 将枚举值转换成对应的routeName
  String get routeName => _enumStringMap[this] ?? '';

  // 将appSetting转化为对应的MaterialPageRoute
  MaterialPageRoute getMaterialPageRouteFromSetting(RouteSettings settings) {
    dynamic arguments = settings.arguments;
    switch (this) {
      case PageRouteEnum.home:
        return MaterialPageRoute(settings: settings, builder: (_) => HomePage(arguments: arguments));
      case PageRouteEnum.informationView:
        return MaterialPageRoute(settings: settings, builder: (_) => InformationViewPage(arguments: arguments));
      case PageRouteEnum.sliverRefreshWidget:
        return MaterialPageRoute(settings: settings, builder: (_) => SliverRefreshWidgetPage(arguments: arguments));
      case PageRouteEnum.sliverSections:
        return MaterialPageRoute(settings: settings, builder: (_) => SliverSectionsPage(arguments: arguments));
      case PageRouteEnum.statusWidget:
        return MaterialPageRoute(settings: settings, builder: (_) => StatusWidgetPage(arguments: arguments));
      case PageRouteEnum.toastWidget:
        return MaterialPageRoute(settings: settings, builder: (_) => ToastWidgetPage(arguments: arguments));
      case PageRouteEnum.spVal:
        return MaterialPageRoute(settings: settings, builder: (_) => SpValPage(arguments: arguments));
      case PageRouteEnum.fileScan:
        return MaterialPageRoute(settings: settings, builder: (_) => FilesScanPage(arguments: arguments));
      case PageRouteEnum.regExp:
        return MaterialPageRoute(settings: settings, builder: (_) => RegExpPage(arguments: arguments));
      case PageRouteEnum.indicatorWidget:
        return MaterialPageRoute(settings: settings, builder: (_) => IndicatorWidgetPage(arguments: arguments));
      case PageRouteEnum.getxRefresh:
        return MaterialPageRoute(settings: settings, builder: (_) => GetxRefreshPage(arguments: arguments));
      case PageRouteEnum.maybePop:
        return MaterialPageRoute(settings: settings, builder: (_) => MaybePopPage(arguments: arguments));
      case PageRouteEnum.networks:
        return MaterialPageRoute(settings: settings, builder: (_) => NetworksPage(arguments: arguments));
      case PageRouteEnum.textField:
        return MaterialPageRoute(settings: settings, builder: (_) => TextFieldPage(arguments: arguments));
      case PageRouteEnum.tabBar:
        return MaterialPageRoute(settings: settings, builder: (_) => TabBarPage(arguments: arguments));
    }
  }

  // pushName的调用
  Future push(BuildContext context, {dynamic arguments}) => Navigator.pushNamed(context, routeName, arguments: arguments);

  // 将需要的一些值存储到map中
  void _storeValueToMap() {
    String pageRouteName = '';

    switch (this) {
      case PageRouteEnum.home:
        pageRouteName = _pageRouteNameFrom(HomePage);
        break;
      case PageRouteEnum.informationView:
        pageRouteName = _pageRouteNameFrom(InformationViewPage);
        break;
      case PageRouteEnum.sliverRefreshWidget:
        pageRouteName = _pageRouteNameFrom(SliverRefreshWidgetPage);
        break;
      case PageRouteEnum.sliverSections:
        pageRouteName = _pageRouteNameFrom(SliverSectionsPage);
        break;
      case PageRouteEnum.statusWidget:
        pageRouteName = _pageRouteNameFrom(StatusWidgetPage);
        break;
      case PageRouteEnum.toastWidget:
        pageRouteName = _pageRouteNameFrom(ToastWidgetPage);
        break;
      case PageRouteEnum.spVal:
        pageRouteName = _pageRouteNameFrom(SpValPage);
        break;
      case PageRouteEnum.fileScan:
        pageRouteName = _pageRouteNameFrom(FilesScanPage);
        break;
      case PageRouteEnum.regExp:
        pageRouteName = _pageRouteNameFrom(RegExpPage);
        break;
      case PageRouteEnum.indicatorWidget:
        pageRouteName = _pageRouteNameFrom(IndicatorWidgetPage);
        break;
      case PageRouteEnum.getxRefresh:
        pageRouteName = _pageRouteNameFrom(GetxRefreshPage);
        break;
      case PageRouteEnum.maybePop:
        pageRouteName = _pageRouteNameFrom(MaybePopPage);
        break;
      case PageRouteEnum.networks:
        pageRouteName = _pageRouteNameFrom(NetworksPage);
        break;
      case PageRouteEnum.textField:
        pageRouteName = _pageRouteNameFrom(TextFieldPage);
        break;
      case PageRouteEnum.tabBar:
        pageRouteName = _pageRouteNameFrom(TabBarPage);
        break;
    }

    _stringEnumMap[pageRouteName] = this;
    _enumStringMap[this] = pageRouteName;
  }
}

String _pageRouteNameFrom(var className) => '/' + className.toString();
late Map<String, PageRouteEnum> _stringEnumMap = {};
late Map<PageRouteEnum, String> _enumStringMap = {};
