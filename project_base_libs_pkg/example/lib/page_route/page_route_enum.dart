import 'package:example/pages/project_use/files_scan/files_scan_page.dart';
import 'package:example/pages/project_use/flutter_spin_kit/flutter_spin_kit_page.dart';
import 'package:example/pages/project_use/getx_refresh/getx_refresh_page.dart';
import 'package:example/pages/project_use/information_view/infomation_view_page.dart';
import 'package:example/pages/project_use/loading_animation/loading_animation_page.dart';
import 'package:example/pages/project_use/maybe_pop/maybe_pop_page.dart';
import 'package:example/pages/project_use/networks/networks_page.dart';
import 'package:example/pages/project_use/reg_exp/reg_exp_page.dart';
import 'package:example/pages/project_use/sliver_refresh_widget/slivers_refresh_widget_page.dart';
import 'package:example/pages/project_use/sliver_sections/sliver_sections_page.dart';
import 'package:example/pages/project_use/sp_val/sp_val_page.dart';
import 'package:example/pages/project_use/status_widget/status_widget_page.dart';
import 'package:example/pages/project_use/toast_widget/toast_widget_page.dart';
import 'package:example/pages/tab_bar/tab_bar_page.dart';
import 'package:flutter/material.dart';

enum PageRouteEnum {
  tabBar,
  informationView,
  sliverRefreshWidget,
  sliverSections,
  statusWidget,
  toastWidget,
  spVal,
  fileScan,
  regExp,
  loadingAnimation,
  flutterSpinKit,
  getxRefresh,
  maybePop,
  networks,
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
      case PageRouteEnum.tabBar:
        return MaterialPageRoute(settings: settings, builder: (_) => TabBarPage(arguments: arguments));
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
      case PageRouteEnum.loadingAnimation:
        return MaterialPageRoute(settings: settings, builder: (_) => LoadingAnimationPage(arguments: arguments));
      case PageRouteEnum.flutterSpinKit:
        return MaterialPageRoute(settings: settings, builder: (_) => FlutterSpinKitPage(arguments: arguments));
      case PageRouteEnum.getxRefresh:
        return MaterialPageRoute(settings: settings, builder: (_) => GetxRefreshPage(arguments: arguments));
      case PageRouteEnum.maybePop:
        return MaterialPageRoute(settings: settings, builder: (_) => MaybePopPage(arguments: arguments));
      case PageRouteEnum.networks:
        return MaterialPageRoute(settings: settings, builder: (_) => NetworksPage(arguments: arguments));
    }
  }

  // pushName的调用
  Future push(BuildContext context, {dynamic arguments}) =>
      Navigator.pushNamed(context, routeName, arguments: arguments);

  // 将需要的一些值存储到map中
  void _storeValueToMap() {
    String pageRouteName = '';

    switch (this) {
      case PageRouteEnum.tabBar:
        pageRouteName = _pageRouteNameFrom(TabBarPage);
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
      case PageRouteEnum.loadingAnimation:
        pageRouteName = _pageRouteNameFrom(LoadingAnimationPage);
        break;
      case PageRouteEnum.flutterSpinKit:
        pageRouteName = _pageRouteNameFrom(FlutterSpinKitPage);
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
    }

    _stringEnumMap[pageRouteName] = this;
    _enumStringMap[this] = pageRouteName;
  }
}

String _pageRouteNameFrom(var className) => '/' + className.toString();
late Map<String, PageRouteEnum> _stringEnumMap = {};
late Map<PageRouteEnum, String> _enumStringMap = {};
