import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/pages/base/normal_stateful_widget.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class LoadingAnimationsPage extends NormalStatefulWidget {
  const LoadingAnimationsPage({Key? key}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => LoadingAnimationsPageState();
}

class LoadingAnimationsPageState extends NormalStatefulWidgetState<LoadingAnimationsPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
      );

  Widget _widgetHeader({required String title}) => Container(
        color: Colors.blueGrey,
        height: 40,
        child: Center(child: WidgetsFactory.text(title, color: Colors.white)),
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
                  const SizedBox(height: 20),
                  WidgetsFactory.text(d.toString().split('.').last, fontSize: 12),
                ],
              ),
            );
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
                  const SizedBox(height: 20),
                  WidgetsFactory.text(d.toString().split('.').last, fontSize: 12),
                ],
              ),
            );
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
                  const SizedBox(height: 20),
                  WidgetsFactory.text(d.toString().split('.').last, fontSize: 12),
                ],
              ),
            );
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
                  IndicatorWidget(config: WateryDesertIndicatorConfig(indicatorType: d, size: 100.w, color: Util.randomOpaqueColor)),
                  const SizedBox(height: 20),
                  WidgetsFactory.text(d.toString().split('.').last, fontSize: 12),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
