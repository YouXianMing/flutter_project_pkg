import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/base_page_build_mixin.dart';

abstract class BaseStatelessWidget extends StatelessWidget with BasePageBuildMixin {
  const BaseStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => buildRootWidget(context);
}
