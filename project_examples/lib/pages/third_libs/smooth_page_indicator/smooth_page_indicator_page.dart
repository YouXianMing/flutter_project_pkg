import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:project_examples/file_headers.dart';

class SmoothPageIndicatorPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const SmoothPageIndicatorPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => SmoothPageIndicatorPageState();
}

class SmoothPageIndicatorPageState extends NormalStatefulWidgetState<SmoothPageIndicatorPage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  /// 无限循环滑动(PageView如果不设定itemCount,就能无限滑动)
  bool infiniteLooping = false;

  /// 颜色数组
  List<Color> colors = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 20; i++) {
      colors.add(Util.randomColor);
    }
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    final pages = _listWidgets();
    return CustomScrollView(
      slivers: [
        SliverListSection.staticTypeWidget(
          children: [
            _widgetPageView(pages),

            /* SmoothPageIndicator - start */
            _widgetColorTransitionEffect(pages.length),
            _widgetCustomizableEffect(pages.length),
            _widgetExpandingDotsEffect(pages.length),
            _widgetWormEffect(pages.length),
            _widgetJumpingDotEffect(pages.length),
            _widgetScaleEffect(pages.length),
            _widgetSlideEffect(pages.length),
            infiniteLooping ? const SizedBox() : _widgetSwapEffect(pages.length),
            _widgetScrollingDotsEffect(pages.length),
            /* SmoothPageIndicator - end */

            const SizedBox(height: 100),
          ],
        ),
      ],
    );
  }

  Widget _widgetJumpingDotEffect(int count) {
    return Column(
      children: [
        WidgetsFactory.text('JumpingDotEffect', color: Colors.black54).addPaddingOnly(top: 10.w, bottom: 10.w),
        SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: const JumpingDotEffect(dotHeight: 16, dotWidth: 16, jumpScale: .7, verticalOffset: 15),
        ).addDebugContainer(),
      ],
    );
  }

  Widget _widgetColorTransitionEffect(int count) {
    return Column(
      children: [
        WidgetsFactory.text('ColorTransitionEffect', color: Colors.black54).addPaddingOnly(top: 10.w, bottom: 10.w),
        SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: const ColorTransitionEffect(),
        ).addDebugContainer(),
      ],
    );
  }

  Widget _widgetExpandingDotsEffect(int count) {
    return Column(
      children: [
        WidgetsFactory.text('ExpandingDotsEffect', color: Colors.black54).addPaddingOnly(top: 10.w, bottom: 10.w),
        SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: const ExpandingDotsEffect(),
        ).addDebugContainer(),
      ],
    );
  }

  Widget _widgetScaleEffect(int count) {
    return Column(
      children: [
        WidgetsFactory.text('ScaleEffect', color: Colors.black54).addPaddingOnly(top: 10.w, bottom: 10.w),
        SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: const ScaleEffect(),
        ).addDebugContainer(),
      ],
    );
  }

  Widget _widgetSlideEffect(int count) {
    return Column(
      children: [
        WidgetsFactory.text('SlideEffect', color: Colors.black54).addPaddingOnly(top: 10.w, bottom: 10.w),
        SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: const SlideEffect(),
        ).addDebugContainer(),
      ],
    );
  }

  Widget _widgetWormEffect(int count) {
    return Column(
      children: [
        WidgetsFactory.text('WormEffect', color: Colors.black54).addPaddingOnly(top: 10.w, bottom: 10.w),
        SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: const WormEffect(dotHeight: 16, dotWidth: 16, type: WormType.thin, strokeWidth: 5),
        ).addDebugContainer(),
      ],
    );
  }

  Widget _widgetSwapEffect(int count) {
    return Column(
      children: [
        WidgetsFactory.text('SwapEffect', color: Colors.black54).addPaddingOnly(top: 10.w, bottom: 10.w),
        SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: const SwapEffect(dotHeight: 16, dotWidth: 16, type: SwapType.yRotation),
        ).addDebugContainer(),
      ],
    );
  }

  Widget _widgetScrollingDotsEffect(int count) {
    return Column(
      children: [
        WidgetsFactory.text('ScrollingDotsEffect', color: Colors.black54).addPaddingOnly(top: 10.w, bottom: 10.w),
        SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: const ScrollingDotsEffect(
            activeStrokeWidth: 2.6,
            activeDotScale: 1.3,
            maxVisibleDots: 5,
            radius: 8,
            spacing: 10,
            dotHeight: 12,
            dotWidth: 12,
          ),
        ).addDebugContainer(),
      ],
    );
  }

  Widget _widgetCustomizableEffect(int count) {
    return Column(
      children: [
        WidgetsFactory.text('CustomizableEffect', color: Colors.black54).addPaddingOnly(top: 10.w, bottom: 10.w),
        SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: CustomizableEffect(
            activeDotDecoration: DotDecoration(
              width: 32,
              height: 12,
              color: Colors.indigo,
              rotationAngle: 180,
              verticalOffset: -10,
              borderRadius: BorderRadius.circular(24),
              dotBorder: const DotBorder(padding: 2, width: 2, color: Colors.indigo),
            ),
            dotDecoration: DotDecoration(
              width: 24,
              height: 12,
              color: Colors.grey,
              dotBorder: const DotBorder(padding: 2, width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
              verticalOffset: 0,
            ),
            spacing: 6.0,
            // activeColorOverride: (i) => colors[i],
            inActiveColorOverride: (i) => colors[i],
          ),
        ).addDebugContainer(),
      ],
    );
  }

  /// 顶部的PageView
  Widget _widgetPageView(List<Widget> widgets) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(top: 20.w, bottom: 20.w),
      child: PageView.builder(
        controller: controller,
        itemCount: infiniteLooping ? null : widgets.length,
        itemBuilder: (_, index) => widgets[index % widgets.length],
      ),
    );
  }

  /// PageView用的widget数组
  List<Container> _listWidgets() {
    return List.generate(
      8,
      (index) => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey.shade300),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(child: Text('Page $index', style: const TextStyle(color: Colors.indigo))),
      ),
    );
  }
}
