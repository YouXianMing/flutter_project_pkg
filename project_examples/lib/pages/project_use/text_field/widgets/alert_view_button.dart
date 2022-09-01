import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

/// AlertView按钮样式
enum AlertViewButtonStyle {
  blue,
  gray,
  red,
}

typedef AlertButtonCallback = void Function(dynamic);

/// AlertView按钮的widget
class AlertViewButton extends StatelessWidget {
  final AlertViewButtonStyle style;
  final String title;
  final bool bold;
  final AlertButtonCallback? onTap;

  const AlertViewButton({
    Key? key,
    required this.title,
    this.style = AlertViewButtonStyle.blue,
    this.bold = false,
    this.onTap,
  }) : super(key: key);

  static AlertViewButton boldBlue(String title, {AlertButtonCallback? onTap}) {
    return AlertViewButton(title: title, bold: true, style: AlertViewButtonStyle.blue, onTap: onTap);
  }

  static AlertViewButton blue(String title, {AlertButtonCallback? onTap}) {
    return AlertViewButton(title: title, bold: false, style: AlertViewButtonStyle.blue, onTap: onTap);
  }

  static AlertViewButton gray(String title, {AlertButtonCallback? onTap}) {
    return AlertViewButton(title: title, bold: false, style: AlertViewButtonStyle.gray, onTap: onTap);
  }

  static AlertViewButton red(String title, {AlertButtonCallback? onTap}) {
    return AlertViewButton(title: title, bold: false, style: AlertViewButtonStyle.red, onTap: onTap);
  }

  static AlertViewButton boldRed(String title, {AlertButtonCallback? onTap}) {
    return AlertViewButton(title: title, bold: true, style: AlertViewButtonStyle.red, onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (style) {
      case AlertViewButtonStyle.blue:
        color = HexColor('007AFF');
        break;
      case AlertViewButtonStyle.gray:
        color = HexColor('979797');
        break;
      case AlertViewButtonStyle.red:
        color = HexColor('FF0F00');
        break;
    }

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: WidgetsFactory.text(title, textAlign: TextAlign.center, fontSize: 16, color: color),
    );
  }
}
