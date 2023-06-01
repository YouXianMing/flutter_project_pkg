import 'package:flutter/material.dart';

/// AppBar的抽象类
abstract class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({Key? key}) : super(key: key);

  /// (abstract) 构建LeadingWidget
  Widget? buildLeadingWidget(BuildContext context);

  /// (abstract) 构建ContentWidget
  Widget? buildContentWidget(BuildContext context);

  /// (abstract) 构建TrailingWidget
  Widget? buildTrailingWidget(BuildContext context);

  /// 调用此方法会会触发WillPopScope中的onWillPop方法调用(如果当前页面设置了WillPopScope),如果没有设置,则直接pop
  Future<bool> maybePop<T extends Object?>(BuildContext context, [T? result]) => Navigator.of(context).maybePop();

  /// 构建主widget
  Widget buildRootWidget(BuildContext context) {
    bool ltr = (Directionality.of(context) == TextDirection.ltr);
    double? value1 = ltr ? 0 : null;
    double? value2 = ltr ? null : 0;

    return Container(
      color: backgroundColor ?? Colors.transparent,
      child: SafeArea(
        top: addSafeAreaTop,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                      left: leadingWidgetWidth,
                      right: trailingWidgetWidth,
                      top: 0,
                      bottom: 0,
                      child: buildContentWidget(context) ?? Container()),
                  Positioned(
                      left: value1,
                      top: 0,
                      bottom: 0,
                      right: value2,
                      child: buildLeadingWidget(context) ?? Container(width: leadingWidgetWidth)),
                  Positioned(
                      right: value1,
                      top: 0,
                      bottom: 0,
                      left: value2,
                      child: buildTrailingWidget(context) ?? Container(width: trailingWidgetWidth)),
                ],
              ),
            ),
            Container(height: lineHeight, color: lineColor)
          ],
        ),
      ),
    );
  }

  /// 线条高度,默认0
  double get lineHeight => 0;

  /// 线条颜色,默认透明色
  Color get lineColor => Colors.transparent;

  /// 添加安全区顶部间隙,默认添加
  bool get addSafeAreaTop => true;

  /// appBar背景色,默认透明色
  Color? get backgroundColor => Colors.transparent;

  /// leadingWidget的宽度,默认60
  double get leadingWidgetWidth => 60;

  /// trailingWidget的宽度,默认60
  double get trailingWidgetWidth => 60;

  /// preferredSize的高度
  double get preferredSizeHeight => kToolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(preferredSizeHeight);

  @override
  Widget build(BuildContext context) => buildRootWidget(context);
}
