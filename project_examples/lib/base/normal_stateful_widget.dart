import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/managers/maybe_pop_manager.dart';
import 'package:project_base_libs_pkg/base/tools/app_print.dart';
import 'package:project_examples/base/normal_page_build_mixin.dart';
import 'package:project_base_libs_pkg/base/tools/hex_color.dart';
import 'package:project_base_libs_pkg/base/widgets/base_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';

abstract class NormalStatefulWidget extends BaseStatefulWidget {
  /// (abstract) arguments参数
  PageArguments? get arguments;

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
  Future? checkWillPop(BuildContext context) => Future.value(MaybePopManager.getInstance.canPop());

  @override
  void dispose() {
    super.dispose();
    if (kDebugMode) print('⚪️ $widget dispose ⚪️');
  }
}
