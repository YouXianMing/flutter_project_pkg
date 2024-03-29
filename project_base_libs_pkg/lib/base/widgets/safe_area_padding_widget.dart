import 'package:flutter/material.dart';

enum SafeAreaPadding { top, bottom, left, right }

class SafeAreaPaddingWidget extends StatelessWidget {
  /// 背景色,如果为空,则默认为透明色
  final Color? backgroundColor;

  /// 安全距离类型,分为左,右,上,下
  final SafeAreaPadding type;

  const SafeAreaPaddingWidget({
    Key? key,
    this.backgroundColor,
    required this.type,
  }) : super(key: key);

  static SafeAreaPaddingWidget top({Color? backgroundColor}) =>
      SafeAreaPaddingWidget(type: SafeAreaPadding.top, backgroundColor: backgroundColor);

  static SafeAreaPaddingWidget bottom({Color? backgroundColor}) =>
      SafeAreaPaddingWidget(type: SafeAreaPadding.bottom, backgroundColor: backgroundColor);

  static SafeAreaPaddingWidget left({Color? backgroundColor}) =>
      SafeAreaPaddingWidget(type: SafeAreaPadding.left, backgroundColor: backgroundColor);

  static SafeAreaPaddingWidget right({Color? backgroundColor}) =>
      SafeAreaPaddingWidget(type: SafeAreaPadding.right, backgroundColor: backgroundColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height(context),
      width: _width(context),
      color: backgroundColor ?? Colors.transparent,
    );
  }

  double? _height(BuildContext context) {
    if (type == SafeAreaPadding.top) {
      return MediaQuery.of(context).padding.top;
    } else if (type == SafeAreaPadding.bottom) {
      return MediaQuery.of(context).padding.bottom;
    }
    return null;
  }

  double? _width(BuildContext context) {
    if (type == SafeAreaPadding.left) {
      return MediaQuery.of(context).padding.left;
    } else if (type == SafeAreaPadding.right) {
      return MediaQuery.of(context).padding.right;
    }
    return null;
  }
}
