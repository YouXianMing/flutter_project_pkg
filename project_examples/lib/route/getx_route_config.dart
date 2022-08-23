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
import 'package:project_examples/pages/third_libs/screen_info/screen_info_page.dart';
import 'package:project_examples/pages/third_libs/shimmer/shimmer_page.dart';
import 'package:project_examples/pages/third_libs/snapping_sheet/snapping_sheet_page.dart';
import 'package:project_examples/pages/third_libs/third_lib_page.dart';
import 'package:project_examples/pages/third_libs/timer_count_down/timer_count_donw_page.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class RouteConfig {
  /// tabBar
  static const String tabBarPage = '/';

  /// root
  static const String homePage = '/HomePage';
  static const String categoryPage = '/CategoryPage';
  static const String cartPage = '/CartPage';
  static const String accountPage = '/AccountPage';

  /// 项目用
  static const String projectUsePage = '/ProjectUsePage';
  static const String sliverSectionsPage = '/SliverSectionsPage';
  static const String informationViewPage = '/InformationViewPage';
  static const String sliverRefreshWidgetPage = '/SliverRefreshWidgetPage';
  static const String toastWidgetPage = '/ToastWidgetPage';

  /// others
  static const String asyncKnowledgePage = '/AsyncKnowledgePage';

  /// 动画相关内容
  static const String animationListPage = '/AnimationListPage';
  static const String groupAnimationPage = '/GroupAnimationPage';
  static const String tweenSequenceAnimationPage = '/TweenSequenceAnimationPage';
  static const String baseAnimatedPage = '/BaseAnimatedUsePage';
  static const String animatedWidgetPage = '/AnimatedWidgetUsePage';
  static const String animationsManagerPage = '/AnimationsManagerUsePage';
  static const String animationsManagerIntervalPage = '/AnimationsManagerIntervalPage';
  static const String animationsManagerSequencePage = '/AnimationsManagerSequencePage';
  static const String animationsManagerRandomPage = '/AnimationsManagerRandomPage';
  static const String animationsManagerCurvesPage = '/AnimationsManagerCurvesPage';
  static const String goodsAddToCartPage = '/GoodsAddToCartPage';

  /// third_libs
  static const String thirdLibPage = '/ThirdLibPage';
  static const String htmlToTextSpanPage = '/HtmlToTextSpanPage';
  static const String loadingAnimationsPage = '/LoadingAnimationsPage';
  static const String shimmerPage = '/ShimmerPage';
  static const String snappingSheetPage = '/SnappingSheetPage';
  static const String staggeredGridViewPage = '/StaggeredGridViewPage';
  static const String lineIconsPage = '/LineIconsPage';
  static const String readMorePage = '/ReadMorePage';
  static const String timerCountDownPage = '/TimerCountDownPage';
  static const String cachedNetworkImagePage = '/CachedNetworkImagePage';
  static const String scratcherPage = '/ScratcherPage';
  static const String flipCardPage = '/FlipCardPage';
  static const String flutterAnimatedButtonPage = '/FlutterAnimatedButtonPage';
  static const String liquidProgressIndicatorPage = '/LiquidProgressIndicatorPage';
  static const String screenUtilPage = '/ScreenUtilPage';

  /// 所有注册的page
  static List<GetPage> getPages() {
    return [
      /// TabBar
      GetPage(name: RouteConfig.tabBarPage, page: () => const TabBarPage()),

      /// Root
      GetPage(name: RouteConfig.homePage, page: () => const HomePage()),
      GetPage(name: RouteConfig.categoryPage, page: () => const CategoryPage()),
      GetPage(name: RouteConfig.cartPage, page: () => const CartPage()),
      GetPage(name: RouteConfig.accountPage, page: () => const AccountPage()),

      /// 项目用
      GetPage(name: RouteConfig.projectUsePage, page: () => const ProjectUsePage()),
      GetPage(name: RouteConfig.sliverSectionsPage, page: () => const SliverSectionsPage()),
      GetPage(name: RouteConfig.informationViewPage, page: () => const InformationViewPage()),
      GetPage(name: RouteConfig.sliverRefreshWidgetPage, page: () => const SliverRefreshWidgetPage()),
      GetPage(name: RouteConfig.toastWidgetPage, page: () => const ToastWidgetPage()),

      /// 学习
      GetPage(name: RouteConfig.asyncKnowledgePage, page: () => const AsyncKnowledgePage()),

      /// 动画相关内容
      GetPage(name: RouteConfig.animationListPage, page: () => const AnimationListPage()),
      GetPage(name: RouteConfig.groupAnimationPage, page: () => const GroupAnimationPage()),
      GetPage(name: RouteConfig.tweenSequenceAnimationPage, page: () => const TweenSequenceAnimationPage()),
      GetPage(name: RouteConfig.baseAnimatedPage, page: () => const BaseAnimatedPage()),
      GetPage(name: RouteConfig.animatedWidgetPage, page: () => const AnimatedWidgetPage()),
      GetPage(name: RouteConfig.animationsManagerPage, page: () => const AnimationsManagerPage()),
      GetPage(name: RouteConfig.goodsAddToCartPage, page: () => const GoodsAddToCartPage()),
      GetPage(name: RouteConfig.animationsManagerIntervalPage, page: () => const AnimationsManagerIntervalPage()),
      GetPage(name: RouteConfig.animationsManagerRandomPage, page: () => const AnimationsManagerRandomPage()),
      GetPage(name: RouteConfig.animationsManagerSequencePage, page: () => const AnimationsManagerSequencePage()),
      GetPage(name: RouteConfig.animationsManagerCurvesPage, page: () => const AnimationsManagerCurvesPage()),

      /// third_libs
      GetPage(name: RouteConfig.screenUtilPage, page: () => const ScreenUtilPage()),
      GetPage(name: RouteConfig.thirdLibPage, page: () => const ThirdLibPage()),
      GetPage(name: RouteConfig.htmlToTextSpanPage, page: () => const HtmlToTextSpanPage()),
      GetPage(name: RouteConfig.loadingAnimationsPage, page: () => const LoadingAnimationsPage()),
      GetPage(name: RouteConfig.shimmerPage, page: () => const ShimmerPage()),
      GetPage(name: RouteConfig.snappingSheetPage, page: () => const SnappingSheetPage()),
      GetPage(name: RouteConfig.staggeredGridViewPage, page: () => const StaggeredGridViewPage()),
      GetPage(name: RouteConfig.lineIconsPage, page: () => const LineIconsPage()),
      GetPage(name: RouteConfig.readMorePage, page: () => const ReadMorePage()),
      GetPage(name: RouteConfig.timerCountDownPage, page: () => const TimerCountDownPage()),
      GetPage(name: RouteConfig.cachedNetworkImagePage, page: () => const CachedNetworkImagePage()),
      GetPage(name: RouteConfig.scratcherPage, page: () => const ScratcherPage()),
      GetPage(name: RouteConfig.flipCardPage, page: () => const FlipCardPage()),
      GetPage(name: RouteConfig.flutterAnimatedButtonPage, page: () => const FlutterAnimatedButtonPage()),
      GetPage(name: RouteConfig.liquidProgressIndicatorPage, page: () => const LiquidProgressIndicatorPage()),
    ];
  }
}
