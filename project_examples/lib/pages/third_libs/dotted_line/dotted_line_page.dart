import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:dotted_line/dotted_line.dart';

class DottedLinePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const DottedLinePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => DottedLinePageState();
}

class DottedLinePageState extends NormalStatefulWidgetState<DottedLinePage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    const space = SizedBox(height: 40);
    return CustomScrollView(
      slivers: [
        SliverListSection.staticTypeWidget(
          children: [
            const Text('Default'),
            const DottedLine(),
            space,
            const Text('Dash length changed'),
            const DottedLine(dashLength: 40),
            space,
            const Text('Dash gap length changed'),
            const DottedLine(dashLength: 30, dashGapLength: 30),
            space,
            const Text('Line thickness changed'),
            const DottedLine(dashLength: 30, dashGapLength: 30, lineThickness: 30),
            space,
            const Text('Dash radius changed'),
            const DottedLine(dashLength: 30, dashGapLength: 30, lineThickness: 30, dashRadius: 16),
            space,
            const Text('Dash and dash gap color changed'),
            const DottedLine(
              dashLength: 30,
              dashGapLength: 30,
              lineThickness: 30,
              dashColor: Colors.blue,
              dashGapColor: Colors.red,
            ),
            space,
            const Text('Line direction and line length changed'),
            const DottedLine(
              dashLength: 30,
              dashGapLength: 30,
              lineThickness: 30,
              dashColor: Colors.blue,
              dashGapColor: Colors.red,
              direction: Axis.vertical,
              lineLength: 150,
            ),
            space,
            const Text('Dash gradient changed'),
            DottedLine(dashGradient: const [Colors.red, Colors.blue], dashLength: 10, lineThickness: 30),
            space,
            const Text('Dash gradient and dash gap gradient changed'),
            DottedLine(
              dashGradient: [Colors.red, Colors.red.withAlpha(0)],
              dashGapGradient: [Colors.blue, Colors.blue.withAlpha(0)],
              dashLength: 10,
              dashGapLength: 10,
              lineThickness: 30,
            ),
            space,
          ],
        ),
      ],
    );
  }
}
