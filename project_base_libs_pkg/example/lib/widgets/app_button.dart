import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/button/animated_button_widget.dart';

enum AppButtonStyle {
  blue,
  red,
}

class AppButton extends StatelessWidget {
  final AppButtonStyle style;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? child;
  final Widget? highlightedChild;
  final Widget? disabledChild;
  final Alignment? alignment;
  final double borderRadius;
  final Function onTap;
  final Duration? duration;
  final bool enableAnimated;
  final bool disable;

  const AppButton({
    Key? key,
    required this.style,
    required this.onTap,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.highlightedChild,
    this.disabledChild,
    this.alignment,
    this.child,
    this.borderRadius = 0,
    this.duration = const Duration(milliseconds: 100),
    this.enableAnimated = true,
    this.disable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration? normalDecoration;
    BoxDecoration? highlightedDecoration;
    BoxDecoration? disabledDecoration;

    Color? normalColor;
    Color? highlightedColor;
    Color? disabledColor;

    switch (style) {
      case AppButtonStyle.blue:
        Color nColor = Colors.blue;
        Color hColor = Colors.blue.withOpacity(0.5);
        Color dColor = Colors.grey;
        if (borderRadius > 0) {
          normalDecoration =
              BoxDecoration(color: nColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius)));
          highlightedDecoration =
              BoxDecoration(color: hColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius)));
          disabledDecoration =
              BoxDecoration(color: dColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius)));
        } else {
          normalColor = nColor;
          highlightedColor = hColor;
          disabledColor = dColor;
        }
        break;
      case AppButtonStyle.red:
        Color nColor = Colors.red;
        Color hColor = Colors.red.withOpacity(0.5);
        Color dColor = Colors.grey;
        if (borderRadius > 0) {
          normalDecoration =
              BoxDecoration(color: nColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius)));
          highlightedDecoration =
              BoxDecoration(color: hColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius)));
          disabledDecoration =
              BoxDecoration(color: dColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius)));
        } else {
          normalColor = nColor;
          highlightedColor = hColor;
          disabledColor = dColor;
        }
        break;
    }

    return AnimatedButtonWidget(
      disable: disable,
      enableAnimated: enableAnimated,
      normalStatus: AnimatedButtonWidgetStatus(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        child: child,
        alignment: alignment ?? Alignment.center,
        decoration: normalDecoration,
        color: normalColor,
        duration: duration,
      ),
      highlightedStatus: AnimatedButtonWidgetStatus(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        child: highlightedChild ?? child,
        alignment: alignment ?? Alignment.center,
        decoration: highlightedDecoration,
        color: highlightedColor,
        duration: duration,
      ),
      disableStatus: AnimatedButtonWidgetStatus(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        child: disabledChild ?? child,
        alignment: alignment ?? Alignment.center,
        decoration: disabledDecoration,
        color: disabledColor,
        duration: duration,
      ),
      onTap: onTap,
    );
  }
}
