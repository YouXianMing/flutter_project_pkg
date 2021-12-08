import 'package:flutter/material.dart';
import 'base_page_build_mixin.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => createWidgetState();

  /// (abstract) createWidgetState
  BaseStatefulWidgetState createWidgetState();
}

abstract class BaseStatefulWidgetState<T extends BaseStatefulWidget> extends State<T> with BasePageBuildMixin {
  @override
  Widget build(BuildContext context) => buildRootWidget(context);
}
