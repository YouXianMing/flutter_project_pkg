import 'package:flutter/material.dart';
import 'simple_view_builder.dart';

enum BaseButtonWidgetStatus {
  idle,
  highlighted,
  disabled,
}

class _BaseButtonWidgetController extends SimpleViewBuilderController {
  BaseButtonWidgetStatus currentStatus = BaseButtonWidgetStatus.idle;
  bool disable = false;

  void changeToStatus(BaseButtonWidgetStatus status) {
    if (currentStatus == status) return;
    currentStatus = status;
    update();
  }

  @override
  void didUpdateBuilderController<T extends SimpleViewBuilderController>(T oldController) {
    oldController as _BaseButtonWidgetController;
    if (disable == true) {
      currentStatus = BaseButtonWidgetStatus.disabled;
    } else if (oldController.disable == true && disable == false) {
      currentStatus = BaseButtonWidgetStatus.idle;
    } else {
      currentStatus = oldController.currentStatus;
    }
  }
}

class BaseButtonWidget extends StatelessWidget {
  final _BaseButtonWidgetController _controller = _BaseButtonWidgetController();
  final Widget Function() childBuilder;
  final Widget Function()? highlightedChildBuilder;
  final Widget Function()? disabledChildBuilder;
  final GestureTapCallback? onTap;
  final bool disable;

  BaseButtonWidget(
      {Key? key, required this.childBuilder, this.highlightedChildBuilder, this.disabledChildBuilder, this.onTap, this.disable = false})
      : super(key: key) {
    if (disable) {
      _controller.currentStatus = BaseButtonWidgetStatus.disabled;
    }
    _controller.disable = disable;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: () => disable ? null : _controller.changeToStatus(BaseButtonWidgetStatus.idle),
      onTapDown: (TapDownDetails details) => disable ? null : _controller.changeToStatus(BaseButtonWidgetStatus.highlighted),
      onTapUp: (TapUpDetails details) => disable ? null : _controller.changeToStatus(BaseButtonWidgetStatus.idle),
      onTap: disable ? null : onTap,
      child: SimpleViewBuilder<_BaseButtonWidgetController>(
        init: _controller,
        builder: (c) {
          switch (c.currentStatus) {
            case BaseButtonWidgetStatus.idle:
              return childBuilder();
            case BaseButtonWidgetStatus.highlighted:
              return highlightedChildBuilder != null ? highlightedChildBuilder!() : childBuilder();
            case BaseButtonWidgetStatus.disabled:
              return disabledChildBuilder != null ? disabledChildBuilder!() : childBuilder();
          }
        },
      ),
    );
  }
}
