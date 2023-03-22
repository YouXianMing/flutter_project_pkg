import 'package:flutter/material.dart';
import 'package:project_examples/base/message.dart';
import 'package:project_examples/widgets/project_loading_widget.dart';
import 'package:project_examples/widgets/static_func_widgets.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

mixin NormalPageBuildV2Mixin {
  /// 内部loading
  final InformationView innerLoading =
      InformationView(type: AnimatedWidgetType.simpleToast, waitForBuild: true, builder: (_) => customIndicatorWidget());

  /// 外部loading
  final InformationView outerLoading =
      InformationView(type: AnimatedWidgetType.simpleToast, waitForBuild: true, builder: (_) => customIndicatorWidget());

  /// Future加载控件
  Widget futureLoadingWidget(FutureLoadingWidgetController controller) => FutureLoadingWidget(
        controller: controller,
        duration: const Duration(milliseconds: 150),
      );

  /// Future加载控件控制器
  final futureLoadingWidgetController = FutureLoadingWidgetController(
    initStatus: FutureLoadingStatus.idle,
    loadingWidgetBuilder: (d) => const ProjectLoadingWidget(type: ProjectLoadingWidgetType.loading),
    failedWidgetBuilder: (d, retry) => ProjectLoadingWidget(type: ProjectLoadingWidgetType.error, onTap: retry),
  );

  /// 内部StackContainer
  final StackContainer innerStackContainer = StackContainer();

  /// 外部StackContainer
  final StackContainer outerStackContainer = StackContainer();

  /// 显示toast信息
  void showMessage(BuildContext context, String text,
          {bool success = true, Duration duration = const Duration(seconds: 2), Function? didHide}) =>
      Message().show(context, text, success: success, duration: duration, didHide: didHide);
}
