import 'package:flutter/material.dart';
import 'package:project_examples/pages/animations/animated_widget/animated_widget_page.dart';
import 'package:project_examples/pages/animations/animation_list_page.dart';
import 'package:project_examples/pages/animations/animations_manager_curves/animations_manager_curves_page.dart';
import 'package:project_examples/pages/animations/animations_manager_interval/animations_manager_interval_page.dart';
import 'package:project_examples/pages/animations/animations_manager/animations_manager_page.dart';
import 'package:project_examples/pages/animations/animations_manager_random/animations_manager_random_page.dart';
import 'package:project_examples/pages/animations/animations_manager_sequence/animations_manager_sequence_page.dart';
import 'package:project_examples/pages/animations/base_animated/base_animated_page.dart';
import 'package:project_examples/pages/animations/goods_add_to_cart/goods_add_to_cart_page.dart';
import 'package:project_examples/pages/animations/group_animation/group_animation_page.dart';
import 'package:project_examples/pages/animations/tween_sequence_animation/tween_sequence_animation_page.dart';
import 'package:project_examples/pages/async_knowledge/async_knowledge_page.dart';
import 'package:project_examples/pages/project_use/information_view/infomation_view_page.dart';
import 'package:project_examples/pages/project_use/project_use_page.dart';
import 'package:project_examples/pages/project_use/sliver_refresh_widget/slivers_refresh_widget_page.dart';
import 'package:project_examples/pages/project_use/sliver_sections/sliver_sections_page.dart';
import 'package:project_examples/pages/project_use/toast_widget/toast_widget_page.dart';
import 'package:project_examples/pages/tab_bar/account_page.dart';
import 'package:project_examples/pages/tab_bar/cart_page.dart';
import 'package:project_examples/pages/tab_bar/category_page.dart';
import 'package:project_examples/pages/tab_bar/home_page.dart';
import 'package:project_examples/pages/tab_bar/tab_bar_page.dart';
import 'package:project_examples/pages/third_libs/cached_network_image/cached_network_image_page.dart';
import 'package:project_examples/pages/third_libs/flip_card/flip_card_page.dart';
import 'package:project_examples/pages/third_libs/flutter_animated_button/flutter_animated_button_page.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_grid_view/flutter_staggered_grid_view_page.dart';
import 'package:project_examples/pages/third_libs/html_text/html_to_text_span_page.dart';
import 'package:project_examples/pages/third_libs/line_icons/line_icons_page.dart';
import 'package:project_examples/pages/third_libs/liquid_progress_indicator/liquid_progress_indicator_page.dart';
import 'package:project_examples/pages/third_libs/loading_animations/loading_animations_page.dart';
import 'package:project_examples/pages/third_libs/read_more/read_more_page.dart';
import 'package:project_examples/pages/third_libs/scratcher/scratcher_page.dart';
import 'package:project_examples/pages/third_libs/shimmer/shimmer_page.dart';
import 'package:project_examples/pages/third_libs/snapping_sheet/snapping_sheet_page.dart';
import 'package:project_examples/pages/third_libs/third_lib_page.dart';
import 'package:project_examples/pages/third_libs/timer_count_down/timer_count_donw_page.dart';

enum PageRouteEnum {
  /* 动画 */
  animatedWidgetPage,
  animationsManagerPage,
  animationsManagerCurvesPage,
  animationsManagerIntervalPage,
  animationsManagerRandomPage,
  animationsManagerSequencePage,
  baseAnimatedPage,
  goodsAddToCartPage,
  groupAnimationPage,
  tweenSequenceAnimationPage,
  animationListPage,
}

/// pageRouteEnum的准备操作,请放在main里
void pageRouteEnumPrepare() {
  for (var value in PageRouteEnum.values) {
    value._storeValueToMap();
  }
}

/// 根据路由名字转化成enum值
PageRouteEnum? pageRouteEnumFromName(String name) => _stringEnumMap[name];

extension PageRouteEnumExtension on PageRouteEnum {
  /// 将枚举值转换成对应的routeName
  String get routeName => _enumStringMap[this] ?? '';

  /// 将appSetting转化为对应的MaterialPageRoute
  MaterialPageRoute getMaterialPageRouteFromSetting(RouteSettings settings) {
    dynamic arguments = settings.arguments;

    switch (this) {
      case PageRouteEnum.animatedWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => AnimatedWidgetPage(arguments: arguments));
      case PageRouteEnum.animationsManagerPage:
        return MaterialPageRoute(settings: settings, builder: (_) => AnimationsManagerPage(arguments: arguments));
      case PageRouteEnum.animationsManagerCurvesPage:
        return MaterialPageRoute(settings: settings, builder: (_) => AnimationsManagerCurvesPage(arguments: arguments));
      case PageRouteEnum.animationsManagerIntervalPage:
        return MaterialPageRoute(settings: settings, builder: (_) => AnimationsManagerIntervalPage(arguments: arguments));
      case PageRouteEnum.animationsManagerRandomPage:
        return MaterialPageRoute(settings: settings, builder: (_) => AnimationsManagerRandomPage(arguments: arguments));
      case PageRouteEnum.animationsManagerSequencePage:
        return MaterialPageRoute(settings: settings, builder: (_) => AnimationsManagerSequencePage(arguments: arguments));
      case PageRouteEnum.baseAnimatedPage:
        return MaterialPageRoute(settings: settings, builder: (_) => BaseAnimatedPage(arguments: arguments));
      case PageRouteEnum.goodsAddToCartPage:
        return MaterialPageRoute(settings: settings, builder: (_) => GoodsAddToCartPage(arguments: arguments));
      case PageRouteEnum.groupAnimationPage:
        return MaterialPageRoute(settings: settings, builder: (_) => GroupAnimationPage(arguments: arguments));
      case PageRouteEnum.tweenSequenceAnimationPage:
        return MaterialPageRoute(settings: settings, builder: (_) => TweenSequenceAnimationPage(arguments: arguments));
      case PageRouteEnum.animationListPage:
        return MaterialPageRoute(settings: settings, builder: (_) => AnimationListPage(arguments: arguments));
    }
  }

  /// pushName的调用
  Future push(BuildContext context, {dynamic arguments}) => Navigator.pushNamed(context, routeName, arguments: arguments);

  /// 将需要的一些值存储到map中
  void _storeValueToMap() {
    String pageRouteName = '';

    switch (this) {
      case PageRouteEnum.animatedWidgetPage:
        pageRouteName = _pageRouteNameFrom(AnimatedWidgetPage);
        break;
      case PageRouteEnum.animationsManagerPage:
        pageRouteName = _pageRouteNameFrom(AnimationsManagerPage);
        break;
      case PageRouteEnum.animationsManagerCurvesPage:
        pageRouteName = _pageRouteNameFrom(AnimationsManagerCurvesPage);
        break;
      case PageRouteEnum.animationsManagerIntervalPage:
        pageRouteName = _pageRouteNameFrom(AnimationsManagerIntervalPage);
        break;
      case PageRouteEnum.animationsManagerRandomPage:
        pageRouteName = _pageRouteNameFrom(AnimationsManagerRandomPage);
        break;
      case PageRouteEnum.animationsManagerSequencePage:
        pageRouteName = _pageRouteNameFrom(AnimationsManagerSequencePage);
        break;
      case PageRouteEnum.baseAnimatedPage:
        pageRouteName = _pageRouteNameFrom(BaseAnimatedPage);
        break;
      case PageRouteEnum.goodsAddToCartPage:
        pageRouteName = _pageRouteNameFrom(GoodsAddToCartPage);
        break;
      case PageRouteEnum.groupAnimationPage:
        pageRouteName = _pageRouteNameFrom(GroupAnimationPage);
        break;
      case PageRouteEnum.tweenSequenceAnimationPage:
        pageRouteName = _pageRouteNameFrom(TweenSequenceAnimationPage);
        break;
      case PageRouteEnum.animationListPage:
        pageRouteName = _pageRouteNameFrom(AnimationListPage);
        break;
    }

    _stringEnumMap[pageRouteName] = this;
    _enumStringMap[this] = pageRouteName;
  }
}

/// 将className转换成page的routeName
String _pageRouteNameFrom(var className) => '/$className';

/// routeName : enum 的map结构
Map<String, PageRouteEnum> _stringEnumMap = {};

/// enum : routeName 的map结构
Map<PageRouteEnum, String> _enumStringMap = {};
