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
import 'package:project_examples/pages/async_knowledge/async_await_example_page.dart';
import 'package:project_examples/pages/async_knowledge/async_knowledge_page.dart';
import 'package:project_examples/pages/async_knowledge/completer_page.dart';
import 'package:project_examples/pages/async_knowledge/dart_async_page.dart';
import 'package:project_examples/pages/async_knowledge/dart_future_page.dart';
import 'package:project_examples/pages/async_knowledge/dart_stream_page.dart';
import 'package:project_examples/pages/async_knowledge/future_builder_page.dart';
import 'package:project_examples/pages/async_knowledge/isolate_page.dart';
import 'package:project_examples/pages/async_knowledge/stream_builder_page.dart';
import 'package:project_examples/pages/project_use/information_view/information_view_page.dart';
import 'package:project_examples/pages/project_use/project_use_page.dart';
import 'package:project_examples/pages/project_use/sliver_refresh_widget/sliver_refresh_widget_page.dart';
import 'package:project_examples/pages/project_use/sliver_sections/sliver_sections_page.dart';
import 'package:project_examples/pages/project_use/toast_widget/toast_widget_page.dart';
import 'package:project_examples/pages/tab_bar/tab_bar_page.dart';
import 'package:project_examples/pages/third_libs/cached_network_image/cached_network_image_page.dart';
import 'package:project_examples/pages/third_libs/flip_card/flip_card_page.dart';
import 'package:project_examples/pages/third_libs/flutter_animated_button/flutter_animated_button_page.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_grid_view/flutter_staggered_grid_view_page.dart';
import 'package:project_examples/pages/third_libs/html_to_text_span/html_to_text_span_page.dart';
import 'package:project_examples/pages/third_libs/line_icons/line_icons_page.dart';
import 'package:project_examples/pages/third_libs/liquid_progress_indicator/liquid_progress_indicator_page.dart';
import 'package:project_examples/pages/third_libs/loading_animations/loading_animations_page.dart';
import 'package:project_examples/pages/third_libs/read_more/read_more_page.dart';
import 'package:project_examples/pages/third_libs/scratcher/scratcher_page.dart';
import 'package:project_examples/pages/third_libs/screen_util/screen_util_page.dart';
import 'package:project_examples/pages/third_libs/shimmer/shimmer_page.dart';
import 'package:project_examples/pages/third_libs/snapping_sheet/snapping_sheet_page.dart';
import 'package:project_examples/pages/third_libs/third_lib_page.dart';
import 'package:project_examples/pages/third_libs/timer_count_down/timer_count_down_page.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_examples/route/page_route_enum.dart';

class RouteConfig {
  /// 所有注册的page
  static List<GetPage> getPages() {
    return [
      /// TabBar
      GetPage(name: '/', page: () => const TabBarPage()),

      /// 异步编程
      GetPage(name: PageRouteEnum.asyncKnowledgePage.routeName, page: () => const AsyncKnowledgePage()),
      GetPage(name: PageRouteEnum.asyncAwaitExamplePage.routeName, page: () => const AsyncAwaitExamplePage()),
      GetPage(name: PageRouteEnum.completerPage.routeName, page: () => const CompleterPage()),
      GetPage(name: PageRouteEnum.dartAsyncPage.routeName, page: () => const DartAsyncPage()),
      GetPage(name: PageRouteEnum.dartFuturePage.routeName, page: () => const DartFuturePage()),
      GetPage(name: PageRouteEnum.dartStreamPage.routeName, page: () => const DartStreamPage()),
      GetPage(name: PageRouteEnum.futureBuilderPage.routeName, page: () => const FutureBuilderPage()),
      GetPage(name: PageRouteEnum.isolatePage.routeName, page: () => const IsolatePage()),
      GetPage(name: PageRouteEnum.streamBuilderPage.routeName, page: () => const StreamBuilderPage()),

      /// 项目用库
      GetPage(name: PageRouteEnum.projectUsePage.routeName, page: () => const ProjectUsePage()),
      GetPage(name: PageRouteEnum.sliverSectionsPage.routeName, page: () => const SliverSectionsPage()),
      GetPage(name: PageRouteEnum.informationViewPage.routeName, page: () => const InformationViewPage()),
      GetPage(name: PageRouteEnum.sliverRefreshWidgetPage.routeName, page: () => const SliverRefreshWidgetPage()),
      GetPage(name: PageRouteEnum.toastWidgetPage.routeName, page: () => const ToastWidgetPage()),

      /// 第三方库
      GetPage(name: PageRouteEnum.screenUtilPage.routeName, page: () => const ScreenUtilPage()),
      GetPage(name: PageRouteEnum.thirdLibPage.routeName, page: () => const ThirdLibPage()),
      GetPage(name: PageRouteEnum.htmlToTextSpanPage.routeName, page: () => const HtmlToTextSpanPage()),
      GetPage(name: PageRouteEnum.loadingAnimationsPage.routeName, page: () => const LoadingAnimationsPage()),
      GetPage(name: PageRouteEnum.shimmerPage.routeName, page: () => const ShimmerPage()),
      GetPage(name: PageRouteEnum.snappingSheetPage.routeName, page: () => const SnappingSheetPage()),
      GetPage(name: PageRouteEnum.flutterStaggeredGridViewPage.routeName, page: () => const FlutterStaggeredGridViewPage()),
      GetPage(name: PageRouteEnum.lineIconsPage.routeName, page: () => const LineIconsPage()),
      GetPage(name: PageRouteEnum.readMorePage.routeName, page: () => const ReadMorePage()),
      GetPage(name: PageRouteEnum.timerCountDownPage.routeName, page: () => const TimerCountDownPage()),
      GetPage(name: PageRouteEnum.cachedNetworkImagePage.routeName, page: () => const CachedNetworkImagePage()),
      GetPage(name: PageRouteEnum.scratcherPage.routeName, page: () => const ScratcherPage()),
      GetPage(name: PageRouteEnum.flipCardPage.routeName, page: () => const FlipCardPage()),
      GetPage(name: PageRouteEnum.flutterAnimatedButtonPage.routeName, page: () => const FlutterAnimatedButtonPage()),
      GetPage(name: PageRouteEnum.liquidProgressIndicatorPage.routeName, page: () => const LiquidProgressIndicatorPage()),

      /// 动画
      GetPage(name: PageRouteEnum.animationListPage.routeName, page: () => const AnimationListPage()),
      GetPage(name: PageRouteEnum.groupAnimationPage.routeName, page: () => const GroupAnimationPage()),
      GetPage(name: PageRouteEnum.tweenSequenceAnimationPage.routeName, page: () => const TweenSequenceAnimationPage()),
      GetPage(name: PageRouteEnum.baseAnimatedPage.routeName, page: () => const BaseAnimatedPage()),
      GetPage(name: PageRouteEnum.animatedWidgetPage.routeName, page: () => const AnimatedWidgetPage()),
      GetPage(name: PageRouteEnum.animationsManagerPage.routeName, page: () => const AnimationsManagerPage()),
      GetPage(name: PageRouteEnum.goodsAddToCartPage.routeName, page: () => const GoodsAddToCartPage()),
      GetPage(name: PageRouteEnum.animationsManagerIntervalPage.routeName, page: () => const AnimationsManagerIntervalPage()),
      GetPage(name: PageRouteEnum.animationsManagerRandomPage.routeName, page: () => const AnimationsManagerRandomPage()),
      GetPage(name: PageRouteEnum.animationsManagerSequencePage.routeName, page: () => const AnimationsManagerSequencePage()),
      GetPage(name: PageRouteEnum.animationsManagerCurvesPage.routeName, page: () => const AnimationsManagerCurvesPage()),
    ];
  }
}
