import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class LoadingAnimationsPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const LoadingAnimationsPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => LoadingAnimationsPageState();
}

class LoadingAnimationsPageState extends NormalStatefulWidgetState<LoadingAnimationsPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  Widget _widgetHeader({required String title}) => Container(
        color: Colors.blueGrey,
        height: 40,
        child: Center(child: WidgetsFactory.text(title.capitalCaseString, color: Colors.white)),
      );

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGridSection.builderTypeWidget(
          headerBuilder: (_) => _widgetHeader(title: 'flutter_spinkit'),
          crossAxisCount: 3,
          items: SpinKitIndicatorType.values,
          builder: (c, i, d) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IndicatorWidget(config: SpinKitIndicatorConfig(type: d, color: Util.randomOpaqueColor)),
                  _widgetAnimationItemTitle(d.toString().split('.').last),
                ],
              ),
            ).addTapEvent(() {
              appPrint(d);
            }, includeContainer: true);
          },
        ),
        SliverGridSection.builderTypeWidget(
          headerBuilder: (_) => _widgetHeader(title: 'loading_indicator'),
          crossAxisCount: 3,
          items: TinoGuoIndicatorType.values,
          builder: (c, i, d) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.5, // 限定宽度为当前宽度一半
                    child: IndicatorWidget(
                      config: TinoGuoIndicatorConfig(
                        indicatorType: d,
                        colors: [
                          Util.randomOpaqueColor,
                          Util.randomOpaqueColor,
                          Util.randomOpaqueColor,
                          Util.randomOpaqueColor,
                          Util.randomOpaqueColor,
                          Util.randomOpaqueColor,
                          Util.randomOpaqueColor,
                          Util.randomOpaqueColor,
                          Util.randomOpaqueColor,
                        ],
                      ),
                    ),
                  ),
                  _widgetAnimationItemTitle(d.toString().split('.').last),
                ],
              ),
            ).addTapEvent(() {
              appPrint(d);
            }, includeContainer: true);
          },
        ),
        SliverGridSection.builderTypeWidget(
          headerBuilder: (_) => _widgetHeader(title: 'loading_animations'),
          crossAxisCount: 3,
          items: CytrynIndicatorType.values,
          builder: (c, i, d) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IndicatorWidget(config: CytrynIndicatorConfig(type: d, backgroundColor: Util.randomOpaqueColor)),
                  _widgetAnimationItemTitle(d.toString().split('.').last),
                ],
              ),
            ).addTapEvent(() {
              appPrint(d);
            }, includeContainer: true);
          },
        ),
        SliverGridSection.builderTypeWidget(
          headerBuilder: (_) => _widgetHeader(title: 'watery_desert_indicator'),
          crossAxisCount: 3,
          items: WateryDesertIndicatorType.values,
          builder: (c, i, d) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IndicatorWidget(config: WateryDesertIndicatorConfig(indicatorType: d, size: 50.w, color: Util.randomOpaqueColor)),
                  _widgetAnimationItemTitle(d.toString().split('.').last),
                ],
              ),
            ).addTapEvent(() {
              appPrint(d);
            }, includeContainer: true);
          },
        ),
        SliverBoxAdapterSection.widget(builder: (_) => SafeAreaPaddingWidget.bottom()),
      ],
    );
  }

  Widget _widgetAnimationItemTitle(String text) {
    return WidgetsFactory.text(text.toString().split('.').last.capitalCaseString, fontSize: 12, textAlign: TextAlign.center)
        .addPaddingOnly(top: 20);
  }
}
