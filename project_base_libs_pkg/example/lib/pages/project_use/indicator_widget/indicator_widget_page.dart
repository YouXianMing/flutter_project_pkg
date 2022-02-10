import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class IndicatorWidgetPage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const IndicatorWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _IndicatorWidgetPageState();
}

class _IndicatorWidgetPageState extends NormalStatefulWidgetState<IndicatorWidgetPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) =>
      NormalAppBar(context: context, title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''));

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGridSection.builderTypeWidget(
          headerBuilder: (_) => Container(
            color: Colors.blueGrey,
            height: 40,
            child: Center(child: WidgetsFactory.text('flutter_spinkit', color: Colors.white)),
          ),
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
          headerBuilder: (_) => Container(
            color: Colors.blueGrey,
            height: 40,
            child: Center(child: WidgetsFactory.text('loading_indicator', color: Colors.white)),
          ),
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
          headerBuilder: (_) => Container(
            color: Colors.blueGrey,
            height: 40,
            child: Center(child: WidgetsFactory.text('loading_animations', color: Colors.white)),
          ),
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
          headerBuilder: (_) => Container(
            color: Colors.blueGrey,
            height: 40,
            child: Center(child: WidgetsFactory.text('loading_animation_widget', color: Colors.white)),
          ),
          crossAxisCount: 3,
          items: WateryDesertIndicatorType.values,
          builder: (c, i, d) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IndicatorWidget(
                    config: WateryDesertIndicatorConfig(
                      indicatorType: d,
                      size: 45,
                      color: Util.randomOpaqueColor,
                      secondColor: Util.randomOpaqueColor,
                      thirdColor: Util.randomOpaqueColor,
                    ),
                  ),
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
