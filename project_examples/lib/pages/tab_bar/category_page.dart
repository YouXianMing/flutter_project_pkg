import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';

class CategoryPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const CategoryPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => CategoryPageState();
}

class CategoryPageState extends NormalStatefulWidgetState<CategoryPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    return const Center(child: Text('Category'));
  }
}
