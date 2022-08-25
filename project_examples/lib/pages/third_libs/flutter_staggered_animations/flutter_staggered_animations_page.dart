import 'package:flutter/material.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_animations/screens/card_column_screen.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_animations/screens/card_grid_screen.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_animations/screens/card_list_screen.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class FlutterStaggeredAnimationsPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const FlutterStaggeredAnimationsPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => FlutterStaggeredAnimationsPageState();
}

class FlutterStaggeredAnimationsPageState extends NormalStatefulWidgetState<FlutterStaggeredAnimationsPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: const Text('List Card Test'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CardListScreen()),
              );
            },
          ),
          ElevatedButton(
            child: const Text('Grid Card Test'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CardGridScreen()),
              );
            },
          ),
          ElevatedButton(
            child: const Text('Column Card Test'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CardColumnScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
