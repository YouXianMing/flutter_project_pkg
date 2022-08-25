import 'package:flutter/material.dart';
import 'package:project_examples/base/normal_page_build_mixin.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/route/app_route_manager.dart';

abstract class NormalStatelessWidget extends BaseStatelessWidget with NormalPageBuildMixin {
  /// (abstract) arguments参数
  PageArguments? get arguments;

  NormalStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget firstTimeLoadingWidgetStartLoading(BuildContext context) => firstTimeLoadingWidget.setDone();

  @override
  Widget innerStackContainerWidget(BuildContext context) => innerStackContainer;

  @override
  Widget innerLoadingWidget(BuildContext context) => innerLoading;

  @override
  Widget outerStackContainerWidget(BuildContext context) => outerStackContainer;

  @override
  Widget outerLoadingWidget(BuildContext context) => outerLoading;

  @override
  Widget backgroundWidget(BuildContext context) => Container(color: HexColor('#f6f6f6'));

  @override
  Future? checkWillPop(BuildContext context) => Future.value(MaybePopManager.getInstance.canPop());
}
