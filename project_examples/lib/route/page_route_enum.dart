import 'package:flutter/material.dart';
import 'package:project_examples/pages/animations/animated_widget/animated_widget_page.dart';
import 'package:project_examples/pages/animations/animation_list_page.dart';
import 'package:project_examples/pages/animations/animations_manager/animations_manager_page.dart';
import 'package:project_examples/pages/animations/animations_manager_curves/animations_manager_curves_page.dart';
import 'package:project_examples/pages/animations/animations_manager_interval/animations_manager_interval_page.dart';
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
import 'package:project_examples/pages/practical_tips/practical_tips_page.dart';
import 'package:project_examples/pages/practical_tips/resizeToAvoidBottomInset/resize_to_avoid_bottom_inset_page.dart';
import 'package:project_examples/pages/project_use/animated_switcher_widget/animated_switcher_widget_page.dart';
import 'package:project_examples/pages/project_use/confetti/confetti_page.dart';
import 'package:project_examples/pages/project_use/custom_buttons/custom_buttons_page.dart';
import 'package:project_examples/pages/project_use/custom_tab_bar_widget/custom_tab_bar_widget_page.dart';
import 'package:project_examples/pages/project_use/files_scan/files_scan_page.dart';
import 'package:project_examples/pages/project_use/first_time_loading_widget/first_time_loading_widget_page.dart';
import 'package:project_examples/pages/project_use/future_loading_widget/future_loading_widget_page.dart';
import 'package:project_examples/pages/project_use/get_child_size/get_child_size_page.dart';
import 'package:project_examples/pages/project_use/information_view/information_view_page.dart';
import 'package:project_examples/pages/project_use/layout_mask_widget/layout_mask_widget_page.dart';
import 'package:project_examples/pages/project_use/lottery_carousel_widget/lottery_carousel_widget_page.dart';
import 'package:project_examples/pages/project_use/maybe_pop/maybe_pop_page.dart';
import 'package:project_examples/pages/project_use/networks/networks_page.dart';
import 'package:project_examples/pages/project_use/project_use_page.dart';
import 'package:project_examples/pages/project_use/reg_exp/reg_exp_page.dart';
import 'package:project_examples/pages/project_use/scrolling_parallax_effect/scrolling_parallax_effect_page.dart';
import 'package:project_examples/pages/project_use/sliver_refresh_widget/sliver_refresh_widget_page.dart';
import 'package:project_examples/pages/project_use/sliver_sections/sliver_sections_page.dart';
import 'package:project_examples/pages/project_use/sliver_sections_refresh_widget/sliver_sections_refresh_widget_page.dart';
import 'package:project_examples/pages/project_use/sp_val/sp_val_page.dart';
import 'package:project_examples/pages/project_use/text_field/text_field_page.dart';
import 'package:project_examples/pages/project_use/toast_widget/toast_widget_page.dart';
import 'package:project_examples/pages/tab_bar/language_page.dart';
import 'package:project_examples/pages/third_libs/cached_network_image/cached_network_image_page.dart';
import 'package:project_examples/pages/third_libs/carousel_slider/carousel_slider_page.dart';
import 'package:project_examples/pages/third_libs/confetti_widget/confetti_widget_page.dart';
import 'package:project_examples/pages/third_libs/dotted_border/dotted_border_page.dart';
import 'package:project_examples/pages/third_libs/dotted_line/dotted_line_page.dart';
import 'package:project_examples/pages/third_libs/expandable/expandable_page.dart';
import 'package:project_examples/pages/third_libs/flip_card/flip_card_page.dart';
import 'package:project_examples/pages/third_libs/flutter_animated_button/flutter_animated_button_page.dart';
import 'package:project_examples/pages/third_libs/flutter_picker/flutter_picker_page.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_animations/flutter_staggered_animations_page.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_grid_view/flutter_staggered_grid_view_page.dart';
import 'package:project_examples/pages/third_libs/html_to_text_span/html_to_text_span_page.dart';
import 'package:project_examples/pages/third_libs/line_icons/line_icons_page.dart';
import 'package:project_examples/pages/third_libs/liquid_progress_indicator/liquid_progress_indicator_page.dart';
import 'package:project_examples/pages/third_libs/loading_animations/loading_animations_page.dart';
import 'package:project_examples/pages/third_libs/lottie/lottie_page.dart';
import 'package:project_examples/pages/third_libs/marquee/marquee_page.dart';
import 'package:project_examples/pages/third_libs/marqueer/marqueer_page.dart';
import 'package:project_examples/pages/third_libs/read_more/read_more_page.dart';
import 'package:project_examples/pages/third_libs/scratcher/scratcher_page.dart';
import 'package:project_examples/pages/third_libs/screen_util/screen_util_page.dart';
import 'package:project_examples/pages/third_libs/scrollview_observer/scrollview_observer_page.dart';
import 'package:project_examples/pages/third_libs/shimmer/shimmer_page.dart';
import 'package:project_examples/pages/third_libs/sliding_up_panel/sliding_up_panel_page.dart';
import 'package:project_examples/pages/third_libs/smooth_page_indicator/smooth_page_indicator_page.dart';
import 'package:project_examples/pages/third_libs/snapping_sheet/snapping_sheet_page.dart';
import 'package:project_examples/pages/third_libs/third_lib_page.dart';
import 'package:project_examples/pages/third_libs/timer_count_down/timer_count_down_page.dart';
import 'package:project_examples/pages/third_libs/wave/wave_page.dart';
import 'package:project_examples/pages/third_libs/widget_and_text_animator/widget_and_text_animator_page.dart';

enum PageRouteEnum {
  /* 第三方库 */
  thirdLibPage, // 列表页
  cachedNetworkImagePage,
  flipCardPage,
  flutterAnimatedButtonPage,
  flutterStaggeredGridViewPage,
  htmlToTextSpanPage,
  lineIconsPage,
  liquidProgressIndicatorPage,
  loadingAnimationsPage,
  readMorePage,
  scratcherPage,
  screenUtilPage,
  shimmerPage,
  snappingSheetPage,
  timerCountDownPage,
  carouselSliderPage,
  smoothPageIndicatorPage,
  flutterStaggeredAnimationsPage,
  wavePage,
  dottedBorderPage,
  dottedLinePage,
  expandablePage,
  marqueePage,
  marqueerPage,
  flutterPickerPage,
  scrollviewObserverPage,
  confettiWidgetPage,
  slidingUpPanelPage,
  lottiePage,
  widgetAndTextAnimatorPage,

  /* 项目用库 */
  projectUsePage, // 列表页
  informationViewPage,
  sliverRefreshWidgetPage,
  sliverSectionsRefreshWidgetPage,
  sliverSectionsPage,
  toastWidgetPage,
  lotteryCarouselWidgetPage,
  layoutMaskWidgetPage,
  textFieldPage,
  networksPage,
  spValPage,
  regExpPage,
  customTabBarWidgetPage,
  filesScanPage,
  maybePopPage,
  confettiPage,
  getChildSizePage,
  scrollingParallaxEffectPage,
  animatedSwitcherWidgetPage,
  firstTimeLoadingWidgetPage,
  futureLoadingWidgetPage,
  customButtonsPage,

  /* 动画 */
  animationListPage, // 列表页
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

  /* 异步编程 */
  asyncKnowledgePage, // 列表页
  asyncAwaitExamplePage,
  completerPage,
  dartAsyncPage,
  dartFuturePage,
  dartStreamPage,
  futureBuilderPage,
  isolatePage,
  streamBuilderPage,

  /* 实用技巧 */
  practicalTipsPage, // 列表页
  resizeToAvoidBottomInsetPage,

  /* 其他 */
  languagePage,
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
      case PageRouteEnum.asyncAwaitExamplePage:
        return MaterialPageRoute(settings: settings, builder: (_) => AsyncAwaitExamplePage(arguments: arguments));
      case PageRouteEnum.asyncKnowledgePage:
        return MaterialPageRoute(settings: settings, builder: (_) => AsyncKnowledgePage(arguments: arguments));
      case PageRouteEnum.completerPage:
        return MaterialPageRoute(settings: settings, builder: (_) => CompleterPage(arguments: arguments));
      case PageRouteEnum.dartAsyncPage:
        return MaterialPageRoute(settings: settings, builder: (_) => DartAsyncPage(arguments: arguments));
      case PageRouteEnum.dartFuturePage:
        return MaterialPageRoute(settings: settings, builder: (_) => DartFuturePage(arguments: arguments));
      case PageRouteEnum.dartStreamPage:
        return MaterialPageRoute(settings: settings, builder: (_) => DartStreamPage(arguments: arguments));
      case PageRouteEnum.futureBuilderPage:
        return MaterialPageRoute(settings: settings, builder: (_) => FutureBuilderPage(arguments: arguments));
      case PageRouteEnum.isolatePage:
        return MaterialPageRoute(settings: settings, builder: (_) => IsolatePage(arguments: arguments));
      case PageRouteEnum.streamBuilderPage:
        return MaterialPageRoute(settings: settings, builder: (_) => StreamBuilderPage(arguments: arguments));
      case PageRouteEnum.informationViewPage:
        return MaterialPageRoute(settings: settings, builder: (_) => InformationViewPage(arguments: arguments));
      case PageRouteEnum.sliverRefreshWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => SliverRefreshWidgetPage(arguments: arguments));
      case PageRouteEnum.sliverSectionsPage:
        return MaterialPageRoute(settings: settings, builder: (_) => SliverSectionsPage(arguments: arguments));
      case PageRouteEnum.toastWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => ToastWidgetPage(arguments: arguments));
      case PageRouteEnum.projectUsePage:
        return MaterialPageRoute(settings: settings, builder: (_) => ProjectUsePage(arguments: arguments));
      case PageRouteEnum.cachedNetworkImagePage:
        return MaterialPageRoute(settings: settings, builder: (_) => CachedNetworkImagePage(arguments: arguments));
      case PageRouteEnum.flipCardPage:
        return MaterialPageRoute(settings: settings, builder: (_) => FlipCardPage(arguments: arguments));
      case PageRouteEnum.flutterAnimatedButtonPage:
        return MaterialPageRoute(settings: settings, builder: (_) => FlutterAnimatedButtonPage(arguments: arguments));
      case PageRouteEnum.flutterStaggeredGridViewPage:
        return MaterialPageRoute(settings: settings, builder: (_) => FlutterStaggeredGridViewPage(arguments: arguments));
      case PageRouteEnum.htmlToTextSpanPage:
        return MaterialPageRoute(settings: settings, builder: (_) => HtmlToTextSpanPage(arguments: arguments));
      case PageRouteEnum.lineIconsPage:
        return MaterialPageRoute(settings: settings, builder: (_) => LineIconsPage(arguments: arguments));
      case PageRouteEnum.liquidProgressIndicatorPage:
        return MaterialPageRoute(settings: settings, builder: (_) => LiquidProgressIndicatorPage(arguments: arguments));
      case PageRouteEnum.loadingAnimationsPage:
        return MaterialPageRoute(settings: settings, builder: (_) => LoadingAnimationsPage(arguments: arguments));
      case PageRouteEnum.readMorePage:
        return MaterialPageRoute(settings: settings, builder: (_) => ReadMorePage(arguments: arguments));
      case PageRouteEnum.scratcherPage:
        return MaterialPageRoute(settings: settings, builder: (_) => ScratcherPage(arguments: arguments));
      case PageRouteEnum.screenUtilPage:
        return MaterialPageRoute(settings: settings, builder: (_) => ScreenUtilPage(arguments: arguments));
      case PageRouteEnum.shimmerPage:
        return MaterialPageRoute(settings: settings, builder: (_) => ShimmerPage(arguments: arguments));
      case PageRouteEnum.snappingSheetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => SnappingSheetPage(arguments: arguments));
      case PageRouteEnum.timerCountDownPage:
        return MaterialPageRoute(settings: settings, builder: (_) => TimerCountDownPage(arguments: arguments));
      case PageRouteEnum.thirdLibPage:
        return MaterialPageRoute(settings: settings, builder: (_) => ThirdLibPage(arguments: arguments));
      case PageRouteEnum.carouselSliderPage:
        return MaterialPageRoute(settings: settings, builder: (_) => CarouselSliderPage(arguments: arguments));
      case PageRouteEnum.smoothPageIndicatorPage:
        return MaterialPageRoute(settings: settings, builder: (_) => SmoothPageIndicatorPage(arguments: arguments));
      case PageRouteEnum.flutterStaggeredAnimationsPage:
        return MaterialPageRoute(settings: settings, builder: (_) => FlutterStaggeredAnimationsPage(arguments: arguments));
      case PageRouteEnum.wavePage:
        return MaterialPageRoute(settings: settings, builder: (_) => WavePage(arguments: arguments));
      case PageRouteEnum.dottedBorderPage:
        return MaterialPageRoute(settings: settings, builder: (_) => DottedBorderPage(arguments: arguments));
      case PageRouteEnum.lotteryCarouselWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => LotteryCarouselWidgetPage(arguments: arguments));
      case PageRouteEnum.expandablePage:
        return MaterialPageRoute(settings: settings, builder: (_) => ExpandablePage(arguments: arguments));
      case PageRouteEnum.layoutMaskWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => LayoutMaskWidgetPage(arguments: arguments));
      case PageRouteEnum.textFieldPage:
        return MaterialPageRoute(settings: settings, builder: (_) => TextFieldPage(arguments: arguments));
      case PageRouteEnum.networksPage:
        return MaterialPageRoute(settings: settings, builder: (_) => NetworksPage(arguments: arguments));
      case PageRouteEnum.spValPage:
        return MaterialPageRoute(settings: settings, builder: (_) => SpValPage(arguments: arguments));
      case PageRouteEnum.regExpPage:
        return MaterialPageRoute(settings: settings, builder: (_) => RegExpPage(arguments: arguments));
      case PageRouteEnum.customTabBarWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => CustomTabBarWidgetPage(arguments: arguments));
      case PageRouteEnum.filesScanPage:
        return MaterialPageRoute(settings: settings, builder: (_) => FilesScanPage(arguments: arguments));
      case PageRouteEnum.maybePopPage:
        return MaterialPageRoute(settings: settings, builder: (_) => MaybePopPage(arguments: arguments));
      case PageRouteEnum.dottedLinePage:
        return MaterialPageRoute(settings: settings, builder: (_) => DottedLinePage(arguments: arguments));
      case PageRouteEnum.marqueePage:
        return MaterialPageRoute(settings: settings, builder: (_) => MarqueePage(arguments: arguments));
      case PageRouteEnum.confettiPage:
        return MaterialPageRoute(settings: settings, builder: (_) => ConfettiPage(arguments: arguments));
      case PageRouteEnum.sliverSectionsRefreshWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => SliverSectionsRefreshWidgetPage(arguments: arguments));
      case PageRouteEnum.scrollingParallaxEffectPage:
        return MaterialPageRoute(settings: settings, builder: (_) => ScrollingParallaxEffectPage(arguments: arguments));
      case PageRouteEnum.confettiWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => ConfettiWidgetPage(arguments: arguments));
      case PageRouteEnum.animatedSwitcherWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => AnimatedSwitcherWidgetPage(arguments: arguments));
      case PageRouteEnum.firstTimeLoadingWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => FirstTimeLoadingWidgetPage(arguments: arguments));
      case PageRouteEnum.futureLoadingWidgetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => FutureLoadingWidgetPage(arguments: arguments));
      case PageRouteEnum.slidingUpPanelPage:
        return MaterialPageRoute(settings: settings, builder: (_) => SlidingUpPanelPage(arguments: arguments));
      case PageRouteEnum.lottiePage:
        return MaterialPageRoute(settings: settings, builder: (_) => LottiePage(arguments: arguments));
      case PageRouteEnum.getChildSizePage:
        return MaterialPageRoute(settings: settings, builder: (_) => GetChildSizePage(arguments: arguments));
      case PageRouteEnum.customButtonsPage:
        return MaterialPageRoute(settings: settings, builder: (_) => CustomButtonsPage(arguments: arguments));
      case PageRouteEnum.marqueerPage:
        return MaterialPageRoute(settings: settings, builder: (_) => MarqueerPage(arguments: arguments));
      case PageRouteEnum.flutterPickerPage:
        return MaterialPageRoute(settings: settings, builder: (_) => FlutterPickerPage(arguments: arguments));
      case PageRouteEnum.languagePage:
        return MaterialPageRoute(settings: settings, builder: (_) => LanguagePage(arguments: arguments));
      case PageRouteEnum.widgetAndTextAnimatorPage:
        return MaterialPageRoute(settings: settings, builder: (_) => WidgetAndTextAnimatorPage(arguments: arguments));
      case PageRouteEnum.practicalTipsPage:
        return MaterialPageRoute(settings: settings, builder: (_) => PracticalTipsPage(arguments: arguments));
      case PageRouteEnum.resizeToAvoidBottomInsetPage:
        return MaterialPageRoute(settings: settings, builder: (_) => ResizeToAvoidBottomInsetPage(arguments: arguments));
      case PageRouteEnum.scrollviewObserverPage:
        return MaterialPageRoute(settings: settings, builder: (_) => ScrollviewObserverPage(arguments: arguments));
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
      case PageRouteEnum.asyncAwaitExamplePage:
        pageRouteName = _pageRouteNameFrom(AsyncAwaitExamplePage);
        break;
      case PageRouteEnum.asyncKnowledgePage:
        pageRouteName = _pageRouteNameFrom(AsyncKnowledgePage);
        break;
      case PageRouteEnum.completerPage:
        pageRouteName = _pageRouteNameFrom(CompleterPage);
        break;
      case PageRouteEnum.dartAsyncPage:
        pageRouteName = _pageRouteNameFrom(DartAsyncPage);
        break;
      case PageRouteEnum.dartFuturePage:
        pageRouteName = _pageRouteNameFrom(DartFuturePage);
        break;
      case PageRouteEnum.dartStreamPage:
        pageRouteName = _pageRouteNameFrom(DartStreamPage);
        break;
      case PageRouteEnum.futureBuilderPage:
        pageRouteName = _pageRouteNameFrom(FutureBuilderPage);
        break;
      case PageRouteEnum.isolatePage:
        pageRouteName = _pageRouteNameFrom(IsolatePage);
        break;
      case PageRouteEnum.streamBuilderPage:
        pageRouteName = _pageRouteNameFrom(StreamBuilderPage);
        break;
      case PageRouteEnum.informationViewPage:
        pageRouteName = _pageRouteNameFrom(InformationViewPage);
        break;
      case PageRouteEnum.sliverRefreshWidgetPage:
        pageRouteName = _pageRouteNameFrom(SliverRefreshWidgetPage);
        break;
      case PageRouteEnum.sliverSectionsPage:
        pageRouteName = _pageRouteNameFrom(SliverSectionsPage);
        break;
      case PageRouteEnum.toastWidgetPage:
        pageRouteName = _pageRouteNameFrom(ToastWidgetPage);
        break;
      case PageRouteEnum.projectUsePage:
        pageRouteName = _pageRouteNameFrom(ProjectUsePage);
        break;
      case PageRouteEnum.cachedNetworkImagePage:
        pageRouteName = _pageRouteNameFrom(CachedNetworkImagePage);
        break;
      case PageRouteEnum.flipCardPage:
        pageRouteName = _pageRouteNameFrom(FlipCardPage);
        break;
      case PageRouteEnum.flutterAnimatedButtonPage:
        pageRouteName = _pageRouteNameFrom(FlutterAnimatedButtonPage);
        break;
      case PageRouteEnum.flutterStaggeredGridViewPage:
        pageRouteName = _pageRouteNameFrom(FlutterStaggeredGridViewPage);
        break;
      case PageRouteEnum.htmlToTextSpanPage:
        pageRouteName = _pageRouteNameFrom(HtmlToTextSpanPage);
        break;
      case PageRouteEnum.lineIconsPage:
        pageRouteName = _pageRouteNameFrom(LineIconsPage);
        break;
      case PageRouteEnum.liquidProgressIndicatorPage:
        pageRouteName = _pageRouteNameFrom(LiquidProgressIndicatorPage);
        break;
      case PageRouteEnum.loadingAnimationsPage:
        pageRouteName = _pageRouteNameFrom(LoadingAnimationsPage);
        break;
      case PageRouteEnum.readMorePage:
        pageRouteName = _pageRouteNameFrom(ReadMorePage);
        break;
      case PageRouteEnum.scratcherPage:
        pageRouteName = _pageRouteNameFrom(ScratcherPage);
        break;
      case PageRouteEnum.screenUtilPage:
        pageRouteName = _pageRouteNameFrom(ScreenUtilPage);
        break;
      case PageRouteEnum.shimmerPage:
        pageRouteName = _pageRouteNameFrom(ShimmerPage);
        break;
      case PageRouteEnum.snappingSheetPage:
        pageRouteName = _pageRouteNameFrom(SnappingSheetPage);
        break;
      case PageRouteEnum.timerCountDownPage:
        pageRouteName = _pageRouteNameFrom(TimerCountDownPage);
        break;
      case PageRouteEnum.thirdLibPage:
        pageRouteName = _pageRouteNameFrom(ThirdLibPage);
        break;
      case PageRouteEnum.carouselSliderPage:
        pageRouteName = _pageRouteNameFrom(CarouselSliderPage);
        break;
      case PageRouteEnum.smoothPageIndicatorPage:
        pageRouteName = _pageRouteNameFrom(SmoothPageIndicatorPage);
        break;
      case PageRouteEnum.flutterStaggeredAnimationsPage:
        pageRouteName = _pageRouteNameFrom(FlutterStaggeredAnimationsPage);
        break;
      case PageRouteEnum.wavePage:
        pageRouteName = _pageRouteNameFrom(WavePage);
        break;
      case PageRouteEnum.dottedBorderPage:
        pageRouteName = _pageRouteNameFrom(DottedBorderPage);
        break;
      case PageRouteEnum.lotteryCarouselWidgetPage:
        pageRouteName = _pageRouteNameFrom(LotteryCarouselWidgetPage);
        break;
      case PageRouteEnum.expandablePage:
        pageRouteName = _pageRouteNameFrom(ExpandablePage);
        break;
      case PageRouteEnum.layoutMaskWidgetPage:
        pageRouteName = _pageRouteNameFrom(LayoutMaskWidgetPage);
        break;
      case PageRouteEnum.textFieldPage:
        pageRouteName = _pageRouteNameFrom(TextFieldPage);
        break;
      case PageRouteEnum.networksPage:
        pageRouteName = _pageRouteNameFrom(NetworksPage);
        break;
      case PageRouteEnum.spValPage:
        pageRouteName = _pageRouteNameFrom(SpValPage);
        break;
      case PageRouteEnum.regExpPage:
        pageRouteName = _pageRouteNameFrom(RegExpPage);
        break;
      case PageRouteEnum.customTabBarWidgetPage:
        pageRouteName = _pageRouteNameFrom(CustomTabBarWidgetPage);
        break;
      case PageRouteEnum.filesScanPage:
        pageRouteName = _pageRouteNameFrom(FilesScanPage);
        break;
      case PageRouteEnum.maybePopPage:
        pageRouteName = _pageRouteNameFrom(MaybePopPage);
        break;
      case PageRouteEnum.dottedLinePage:
        pageRouteName = _pageRouteNameFrom(DottedLinePage);
        break;
      case PageRouteEnum.marqueePage:
        pageRouteName = _pageRouteNameFrom(MarqueePage);
        break;
      case PageRouteEnum.confettiPage:
        pageRouteName = _pageRouteNameFrom(ConfettiPage);
        break;
      case PageRouteEnum.sliverSectionsRefreshWidgetPage:
        pageRouteName = _pageRouteNameFrom(SliverSectionsRefreshWidgetPage);
        break;
      case PageRouteEnum.scrollingParallaxEffectPage:
        pageRouteName = _pageRouteNameFrom(ScrollingParallaxEffectPage);
        break;
      case PageRouteEnum.confettiWidgetPage:
        pageRouteName = _pageRouteNameFrom(ConfettiWidgetPage);
        break;
      case PageRouteEnum.animatedSwitcherWidgetPage:
        pageRouteName = _pageRouteNameFrom(AnimatedSwitcherWidgetPage);
        break;
      case PageRouteEnum.firstTimeLoadingWidgetPage:
        pageRouteName = _pageRouteNameFrom(FirstTimeLoadingWidgetPage);
        break;
      case PageRouteEnum.futureLoadingWidgetPage:
        pageRouteName = _pageRouteNameFrom(FutureLoadingWidgetPage);
        break;
      case PageRouteEnum.slidingUpPanelPage:
        pageRouteName = _pageRouteNameFrom(SlidingUpPanelPage);
        break;
      case PageRouteEnum.lottiePage:
        pageRouteName = _pageRouteNameFrom(LottiePage);
        break;
      case PageRouteEnum.getChildSizePage:
        pageRouteName = _pageRouteNameFrom(GetChildSizePage);
        break;
      case PageRouteEnum.customButtonsPage:
        pageRouteName = _pageRouteNameFrom(CustomButtonsPage);
        break;
      case PageRouteEnum.marqueerPage:
        pageRouteName = _pageRouteNameFrom(MarqueerPage);
        break;
      case PageRouteEnum.flutterPickerPage:
        pageRouteName = _pageRouteNameFrom(FlutterPickerPage);
        break;
      case PageRouteEnum.languagePage:
        pageRouteName = _pageRouteNameFrom(LanguagePage);
        break;
      case PageRouteEnum.widgetAndTextAnimatorPage:
        pageRouteName = _pageRouteNameFrom(WidgetAndTextAnimatorPage);
        break;
      case PageRouteEnum.practicalTipsPage:
        pageRouteName = _pageRouteNameFrom(PracticalTipsPage);
        break;
      case PageRouteEnum.resizeToAvoidBottomInsetPage:
        pageRouteName = _pageRouteNameFrom(ResizeToAvoidBottomInsetPage);
        break;
      case PageRouteEnum.scrollviewObserverPage:
        pageRouteName = _pageRouteNameFrom(ScrollviewObserverPage);
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
