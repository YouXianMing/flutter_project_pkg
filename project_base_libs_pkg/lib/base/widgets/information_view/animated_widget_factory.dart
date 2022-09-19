import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class AnimatedWidgetFactory {
  static Widget? animatedWidget<T extends BaseInformationViewConfig>({
    required AnimatedWidgetType type,
    required InformationViewStatus step,
    required Widget? widget,
    required T? config,
    required void Function()? didCompleteShowCallback,
    required void Function()? didCompleteHideCallback,
    required void Function()? backgroundTapCallback,
  }) {
    switch (type) {
      case AnimatedWidgetType.simpleToast:
        return AnimatedSimpleToastView(
          step: step,
          contentWidget: widget!,
          config: null,
          didCompleteShowCallback: didCompleteShowCallback!,
          didCompleteHideCallback: didCompleteHideCallback!,
        );

      case AnimatedWidgetType.popView:
        return AnimatedPopView(
          step: step,
          contentWidget: widget!,
          config: config ?? AnimatedPopViewConfig(),
          didCompleteShowCallback: didCompleteShowCallback!,
          didCompleteHideCallback: didCompleteHideCallback!,
          backgroundTapCallback: backgroundTapCallback!,
        );

      case AnimatedWidgetType.sheetView:
        return AnimatedSheetView(
          step: step,
          contentWidget: widget!,
          config: config ?? AnimatedSheetViewConfig(),
          didCompleteShowCallback: didCompleteShowCallback!,
          didCompleteHideCallback: didCompleteHideCallback!,
          backgroundTapCallback: backgroundTapCallback!,
        );
    }
  }
}
