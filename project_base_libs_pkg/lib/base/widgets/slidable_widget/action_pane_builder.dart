import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// Pane构造器
class ActionPaneBuilder {
  static ActionPane create({
    required List<SlidableActionItem> items,
    Widget motion = const ScrollMotion(),
    bool dragDismissible = true,
    Function()? onDismissed,
    double? openThreshold,
    double? closeThreshold,
    double? extentRatio,
  }) {
    List<Widget> list = [];
    for (var value in items) {
      list.add(value.build());
    }

    return ActionPane(
      motion: motion,
      dismissible: onDismissed != null ? DismissiblePane(onDismissed: onDismissed) : null,
      extentRatio: extentRatio ?? 0.5,
      dragDismissible: dragDismissible,
      openThreshold: openThreshold,
      closeThreshold: closeThreshold,
      children: list,
    );
  }
}

/// Pane中的item
class SlidableActionItem {
  Key? key;
  IconData? icon;
  String? label;
  int flex;
  bool autoClose;
  Color? foregroundColor;
  Color backgroundColor;
  double spacing;
  Function(BuildContext) onPressed;
  BorderRadius borderRadius;
  EdgeInsets? padding;

  SlidableActionItem({
    required this.onPressed,
    this.key,
    this.icon,
    this.label,
    this.flex = 1,
    this.autoClose = true,
    this.foregroundColor,
    this.backgroundColor = Colors.white,
    this.spacing = 4,
    this.borderRadius = BorderRadius.zero,
    this.padding,
  });

  Widget build() {
    return SlidableAction(
      key: key,
      onPressed: onPressed,
      icon: icon,
      label: label,
      flex: flex,
      autoClose: autoClose,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      spacing: spacing,
      borderRadius: borderRadius,
      padding: padding,
    );
  }
}
