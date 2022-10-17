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
import 'package:project_examples/pages/async_knowledge/async_await_example/async_await_example_page.dart';
import 'package:project_examples/pages/async_knowledge/async_knowledge_page.dart';
import 'package:project_examples/pages/async_knowledge/completer/completer_page.dart';
import 'package:project_examples/pages/async_knowledge/dart_async/dart_async_page.dart';
import 'package:project_examples/pages/async_knowledge/dart_future/dart_future_page.dart';
import 'package:project_examples/pages/async_knowledge/dart_stream/dart_stream_page.dart';
import 'package:project_examples/pages/async_knowledge/future_builder/future_builder_page.dart';
import 'package:project_examples/pages/async_knowledge/isolate/isolate_page.dart';
import 'package:project_examples/pages/async_knowledge/stream_builder/stream_builder_page.dart';
import 'package:project_examples/pages/project_use/confetti/confetti_page.dart';
import 'package:project_examples/pages/project_use/custom_tab_bar_widget/custom_tab_bar_widget_page.dart';
import 'package:project_examples/pages/project_use/files_scan/files_scan_page.dart';
import 'package:project_examples/pages/project_use/information_view/information_view_page.dart';
import 'package:project_examples/pages/project_use/layout_mask_widget/layout_mask_widget_page.dart';
import 'package:project_examples/pages/project_use/lottery_carousel_widget/lottery_carousel_widget_page.dart';
import 'package:project_examples/pages/project_use/maybe_pop/maybe_pop_page.dart';
import 'package:project_examples/pages/project_use/networks/networks_page.dart';
import 'package:project_examples/pages/project_use/project_use_page.dart';
import 'package:project_examples/pages/project_use/reg_exp/reg_exp_page.dart';
import 'package:project_examples/pages/project_use/sliver_refresh_widget/sliver_refresh_widget_page.dart';
import 'package:project_examples/pages/project_use/sliver_sections/sliver_sections_page.dart';
import 'package:project_examples/pages/project_use/sliver_sections_refresh_widget/sliver_sections_refresh_widget_page.dart';
import 'package:project_examples/pages/project_use/sp_val/sp_val_page.dart';
import 'package:project_examples/pages/project_use/text_field/text_field_page.dart';
import 'package:project_examples/pages/project_use/toast_widget/toast_widget_page.dart';
import 'package:project_examples/pages/tab_bar/tab_bar_page.dart';
import 'package:project_examples/pages/third_libs/cached_network_image/cached_network_image_page.dart';
import 'package:project_examples/pages/third_libs/carousel_slider/carousel_slider_page.dart';
import 'package:project_examples/pages/third_libs/dotted_border/dotted_border_page.dart';
import 'package:project_examples/pages/third_libs/dotted_line/dotted_line_page.dart';
import 'package:project_examples/pages/third_libs/expandable/expandable_page.dart';
import 'package:project_examples/pages/third_libs/flip_card/flip_card_page.dart';
import 'package:project_examples/pages/third_libs/flutter_animated_button/flutter_animated_button_page.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_animations/flutter_staggered_animations_page.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_grid_view/flutter_staggered_grid_view_page.dart';
import 'package:project_examples/pages/third_libs/html_to_text_span/html_to_text_span_page.dart';
import 'package:project_examples/pages/third_libs/line_icons/line_icons_page.dart';
import 'package:project_examples/pages/third_libs/liquid_progress_indicator/liquid_progress_indicator_page.dart';
import 'package:project_examples/pages/third_libs/loading_animations/loading_animations_page.dart';
import 'package:project_examples/pages/third_libs/marquee/marquee_page.dart';
import 'package:project_examples/pages/third_libs/read_more/read_more_page.dart';
import 'package:project_examples/pages/third_libs/scratcher/scratcher_page.dart';
import 'package:project_examples/pages/third_libs/screen_util/screen_util_page.dart';
import 'package:project_examples/pages/third_libs/shimmer/shimmer_page.dart';
import 'package:project_examples/pages/third_libs/smooth_page_indicator/smooth_page_indicator_page.dart';
import 'package:project_examples/pages/third_libs/snapping_sheet/snapping_sheet_page.dart';
import 'package:project_examples/pages/third_libs/third_lib_page.dart';
import 'package:project_examples/pages/third_libs/timer_count_down/timer_count_down_page.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_examples/pages/third_libs/wave/wave_page.dart';
import 'package:project_examples/route/page_route_enum.dart';

class RouteConfig {
  /// 所有注册的page
  static List<GetPage> getPages() {
    List<GetPage> pages = [];
    pages.add(GetPage(name: '/', page: () => const TabBarPage()));
    for (var element in PageRouteEnum.values) {
      pages.add(
        GetPage(
          name: element.routeName,
          page: () {
            switch (element) {
              case PageRouteEnum.informationViewPage:
                return const InformationViewPage();
              case PageRouteEnum.sliverRefreshWidgetPage:
                return const SliverRefreshWidgetPage();
              case PageRouteEnum.sliverSectionsPage:
                return const SliverSectionsPage();
              case PageRouteEnum.toastWidgetPage:
                return const ToastWidgetPage();
              case PageRouteEnum.projectUsePage:
                return const ProjectUsePage();
              case PageRouteEnum.cachedNetworkImagePage:
                return const CachedNetworkImagePage();
              case PageRouteEnum.flipCardPage:
                return const FlipCardPage();
              case PageRouteEnum.flutterAnimatedButtonPage:
                return const FlutterAnimatedButtonPage();
              case PageRouteEnum.flutterStaggeredGridViewPage:
                return const FlutterStaggeredGridViewPage();
              case PageRouteEnum.htmlToTextSpanPage:
                return const HtmlToTextSpanPage();
              case PageRouteEnum.lineIconsPage:
                return const LineIconsPage();
              case PageRouteEnum.liquidProgressIndicatorPage:
                return const LiquidProgressIndicatorPage();
              case PageRouteEnum.loadingAnimationsPage:
                return const LoadingAnimationsPage();
              case PageRouteEnum.readMorePage:
                return const ReadMorePage();
              case PageRouteEnum.scratcherPage:
                return const ScratcherPage();
              case PageRouteEnum.screenUtilPage:
                return const ScreenUtilPage();
              case PageRouteEnum.shimmerPage:
                return const ShimmerPage();
              case PageRouteEnum.snappingSheetPage:
                return const SnappingSheetPage();
              case PageRouteEnum.timerCountDownPage:
                return const TimerCountDownPage();
              case PageRouteEnum.thirdLibPage:
                return const ThirdLibPage();
              case PageRouteEnum.animatedWidgetPage:
                return const AnimatedWidgetPage();
              case PageRouteEnum.animationsManagerPage:
                return const AnimationsManagerPage();
              case PageRouteEnum.animationsManagerCurvesPage:
                return const AnimationsManagerCurvesPage();
              case PageRouteEnum.animationsManagerIntervalPage:
                return const AnimationsManagerIntervalPage();
              case PageRouteEnum.animationsManagerRandomPage:
                return const AnimationsManagerRandomPage();
              case PageRouteEnum.animationsManagerSequencePage:
                return const AnimationsManagerSequencePage();
              case PageRouteEnum.baseAnimatedPage:
                return const BaseAnimatedPage();
              case PageRouteEnum.goodsAddToCartPage:
                return const GoodsAddToCartPage();
              case PageRouteEnum.groupAnimationPage:
                return const GroupAnimationPage();
              case PageRouteEnum.tweenSequenceAnimationPage:
                return const TweenSequenceAnimationPage();
              case PageRouteEnum.animationListPage:
                return const AnimationListPage();
              case PageRouteEnum.asyncAwaitExamplePage:
                return const AsyncAwaitExamplePage();
              case PageRouteEnum.asyncKnowledgePage:
                return const AsyncKnowledgePage();
              case PageRouteEnum.completerPage:
                return const CompleterPage();
              case PageRouteEnum.dartAsyncPage:
                return const DartAsyncPage();
              case PageRouteEnum.dartFuturePage:
                return const DartFuturePage();
              case PageRouteEnum.dartStreamPage:
                return const DartStreamPage();
              case PageRouteEnum.futureBuilderPage:
                return const FutureBuilderPage();
              case PageRouteEnum.isolatePage:
                return const IsolatePage();
              case PageRouteEnum.streamBuilderPage:
                return const StreamBuilderPage();
              case PageRouteEnum.carouselSliderPage:
                return const CarouselSliderPage();
              case PageRouteEnum.smoothPageIndicatorPage:
                return const SmoothPageIndicatorPage();
              case PageRouteEnum.flutterStaggeredAnimationsPage:
                return const FlutterStaggeredAnimationsPage();
              case PageRouteEnum.wavePage:
                return const WavePage();
              case PageRouteEnum.dottedBorderPage:
                return const DottedBorderPage();
              case PageRouteEnum.lotteryCarouselWidgetPage:
                return const LotteryCarouselWidgetPage();
              case PageRouteEnum.expandablePage:
                return const ExpandablePage();
              case PageRouteEnum.layoutMaskWidgetPage:
                return const LayoutMaskWidgetPage();
              case PageRouteEnum.textFieldPage:
                return const TextFieldPage();
              case PageRouteEnum.networksPage:
                return const NetworksPage();
              case PageRouteEnum.spValPage:
                return const SpValPage();
              case PageRouteEnum.regExpPage:
                return const RegExpPage();
              case PageRouteEnum.customTabBarWidgetPage:
                return const CustomTabBarWidgetPage();
              case PageRouteEnum.filesScanPage:
                return const FilesScanPage();
              case PageRouteEnum.maybePopPage:
                return const MaybePopPage();
              case PageRouteEnum.dottedLinePage:
                return const DottedLinePage();
              case PageRouteEnum.marqueePage:
                return const MarqueePage();
              case PageRouteEnum.confettiPage:
                return const ConfettiPage();
              case PageRouteEnum.sliverSectionsRefreshWidgetPage:
                return const SliverSectionsRefreshWidgetPage();
            }
          },
        ),
      );
    }

    return pages;
  }
}
