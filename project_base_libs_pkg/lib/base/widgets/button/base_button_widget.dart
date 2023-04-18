import 'package:flutter/material.dart';

/// 基础的按钮控件状态枚举值
enum BaseButtonWidgetStatus {
  /// 默认状态
  idle,

  /// 高亮状态
  highlighted,

  /// 禁用状态
  disabled,
}

/// 基础的按钮控件
class BaseButtonWidget extends StatefulWidget {
  /// 默认状态widget构造器,必须有
  final Widget Function() childBuilder;

  /// 高亮状态widget构造器
  final Widget Function()? highlightedChildBuilder;

  /// 禁用状态widget构造器
  final Widget Function()? disabledChildBuilder;

  /// 按钮点击回调
  final GestureTapCallback? onTap;

  /// 按钮是否禁用,默认为false
  final bool disable;

  const BaseButtonWidget({
    Key? key,
    required this.childBuilder,
    this.highlightedChildBuilder,
    this.disabledChildBuilder,
    this.onTap,
    this.disable = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BaseButtonWidgetState();
}

class _BaseButtonWidgetState extends State<BaseButtonWidget> {
  late BaseButtonWidgetStatus currentStatus;

  @override
  void initState() {
    super.initState();
    if (widget.disable == true) {
      currentStatus = BaseButtonWidgetStatus.disabled;
    } else {
      currentStatus = BaseButtonWidgetStatus.idle;
    }
  }

  @override
  void didUpdateWidget(covariant BaseButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.disable == true) {
      // 如果新对象的值为禁用状态,则直接设置成disabled
      currentStatus = BaseButtonWidgetStatus.disabled;
    } else if (widget.disable == false && oldWidget.disable == true) {
      // 如果新对象的值为非禁用状态,而且上一个对象的值为禁用状态,则直接恢复成默认设置
      currentStatus = BaseButtonWidgetStatus.idle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: () => widget.disable ? null : update(BaseButtonWidgetStatus.idle),
      onTapDown: (TapDownDetails details) => widget.disable ? null : update(BaseButtonWidgetStatus.highlighted),
      onTapUp: (TapUpDetails details) => widget.disable ? null : update(BaseButtonWidgetStatus.idle),
      onTap: widget.disable ? null : widget.onTap,
      child: childWidget(),
    );
  }

  Widget childWidget() {
    switch (currentStatus) {
      case BaseButtonWidgetStatus.idle:
        return widget.childBuilder();
      case BaseButtonWidgetStatus.highlighted:
        return widget.highlightedChildBuilder != null ? widget.highlightedChildBuilder!() : widget.childBuilder();
      case BaseButtonWidgetStatus.disabled:
        return widget.disabledChildBuilder != null ? widget.disabledChildBuilder!() : widget.childBuilder();
    }
  }

  void update(BaseButtonWidgetStatus status) {
    // 需要改变的时候才会执行setState
    if (currentStatus != status) {
      currentStatus = status;
      if (mounted) setState(() {});
    }
  }
}
