import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class FlutterSpinKitPage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const FlutterSpinKitPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _FlutterSpinKitPageState();
}

class _FlutterSpinKitPageState extends NormalStatefulWidgetState<FlutterSpinKitPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) =>
      NormalAppBar(context: context, title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''));

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGridSection.builderTypeWidget(
          crossAxisCount: 3,
          items: FlutterSpinKit.values,
          builder: (c, i, d) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlutterSpinKitWidget(type: d, color: Util.randomOpaqueColor),
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
