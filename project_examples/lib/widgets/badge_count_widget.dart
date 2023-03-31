import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class BadgeCountWidget extends StatelessWidget {
  /// 当前消息数目
  final int? count;

  /// 设置数字加粗,默认为false
  final bool setBoldCount;

  /// 当数字为0时,是否继续显示0,默认为false
  final bool showCountWhenZero;

  /// 最大显示的消息数目,超过这个数目后则使用+,例如maxCount为99时,如果count为100,则显示为99+
  final int? maxCount;

  /// badge的高度,默认为18
  final double? badgeHeight;

  /// badge的字体,默认为13
  final double? badgeFontSize;

  /// badge的水平方向的padding,默认为6
  final double? badgeHorizontalPadding;

  /// badge的背景颜色,默认为ENColors.functionalError
  final Color? badgeColor;

  /// badge的文字颜色,默认为白色
  final Color? badgeTextColor;

  const BadgeCountWidget({
    Key? key,
    this.count,
    this.setBoldCount = false,
    this.showCountWhenZero = false,
    this.maxCount,
    this.badgeHeight,
    this.badgeFontSize,
    this.badgeHorizontalPadding,
    this.badgeColor,
    this.badgeTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((count is int == false) || (!showCountWhenZero && count! <= 0)) return const SizedBox();

    var value = count!;
    bool haveWidth = (value < 10);
    double badgeHeight = getT(this.badgeHeight, defaultValue: 0.0) > 0 ? this.badgeHeight! : 18;
    double badgeFontSize = getT(this.badgeFontSize, defaultValue: 0.0) > 0 ? this.badgeFontSize! : 13;
    double badgeHorizontalPadding = getT(this.badgeHorizontalPadding, defaultValue: 0.0) > 0 ? this.badgeHorizontalPadding! : 5;
    String showString = (getT(maxCount, defaultValue: 0) > 0 && value > maxCount! ? '$maxCount+' : '$count');
    return Row(
      children: [
        WidgetsFactory.text(
          showString,
          fontSize: badgeFontSize,
          color: badgeTextColor ?? Colors.white,
        ).addContainerBorderRadius(
          color: badgeColor ?? Colors.red,
          radius: 10000,
          width: haveWidth ? badgeHeight : null,
          padding: haveWidth ? null : EdgeInsets.symmetric(horizontal: badgeHorizontalPadding),
          height: badgeHeight,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
