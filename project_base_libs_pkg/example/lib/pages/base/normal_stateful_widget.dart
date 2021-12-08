import 'package:example/pages/base/normal_page_build_mixin.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

abstract class NormalStatefulWidget extends BaseStatefulWidget {
  const NormalStatefulWidget({Key? key}) : super(key: key);
}

abstract class NormalStatefulWidgetState<T extends NormalStatefulWidget> extends BaseStatefulWidgetState<T> with NormalPageBuildMixin {
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
  bool useWillPopScope(BuildContext context) => !PlatFormInfo.isIOS;

  @override
  Future? checkWillPop(BuildContext context) => Future.value(MaybePopManager.getInstance.canPop());
}
