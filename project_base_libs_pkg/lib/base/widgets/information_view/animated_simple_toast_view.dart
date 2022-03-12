import 'package:flutter/material.dart';
import 'information_view_enums_and_configs.dart';

class AnimatedSimpleToastView extends StatelessWidget {
  final InformationViewStatus? step;
  final Widget? contentWidget;
  final dynamic config;
  final void Function() didCompleteShowCallback;
  final void Function() didCompleteHideCallback;

  const AnimatedSimpleToastView({
    Key? key,
    this.step,
    this.contentWidget,
    this.config,
    required this.didCompleteShowCallback,
    required this.didCompleteHideCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool ignoring = false;
    Duration showDuration = const Duration(milliseconds: 200);
    Duration hideDuration = const Duration(milliseconds: 200);
    var configValue = config as AnimatedSimpleToastViewConfig?;
    if (configValue != null) {
      if (configValue.blockEvent == false) ignoring = true;
      showDuration = configValue.showDuration;
      hideDuration = configValue.hideDuration;
    }

    double opacity = 0;
    Duration? duration;
    Widget? widget;
    if (step == InformationViewStatus.idle) {
      opacity = 0;
      widget = null;
      duration = Duration.zero;
    } else if (step == InformationViewStatus.show) {
      opacity = 1;
      widget = contentWidget!;
      duration = showDuration;
    } else if (step == InformationViewStatus.hide) {
      opacity = 0;
      duration = hideDuration;
      widget = contentWidget!;
    }

    if (step == InformationViewStatus.show) {
      Future.delayed(duration!, () => didCompleteShowCallback());
    } else if (step == InformationViewStatus.hide) {
      Future.delayed(duration!, () => didCompleteHideCallback());
    }

    var returnWidget = AnimatedOpacity(opacity: opacity, duration: duration!, child: widget);
    return ignoring ? IgnorePointer(ignoring: true, child: returnWidget) : returnWidget;
  }
}
