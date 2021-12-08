import 'package:flutter/material.dart';
import 'base_page_build_mixin.dart';

abstract class BaseStatelessWidget extends StatelessWidget with BasePageBuildMixin {
  const BaseStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => buildRootWidget(context);
}
