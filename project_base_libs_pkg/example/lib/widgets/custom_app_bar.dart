import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

///
/// 通用类型的AppBar
///
class NormalAppBar extends BaseAppBar {
  static Widget titleWidget(String text) {
    return WidgetsFactory.text(text, fontSize: 20, maxLines: 1, overflow: TextOverflow.ellipsis);
  }

  /// title的widget,可以是图片
  final Widget? title;

  /// 返回按钮事件,默认不需要赋值
  final GestureTapCallback? popBackTap;

  /// BuildContext,必须有
  final BuildContext context;

  /// 隐藏返回按钮,默认不隐藏
  final bool hideBackButton;

  final List<Widget> trailingWidgets;

  final double bottomLineHeight;

  /// 构造方法
  const NormalAppBar({
    Key? key,
    required this.context,
    this.title,
    this.popBackTap,
    this.hideBackButton = false,
    this.bottomLineHeight = 1,
    this.trailingWidgets = const [],
  }) : super(key: key);

  @override
  double get lineHeight => bottomLineHeight;

  @override
  Color get lineColor => HexColor('#f7f7f7');

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? buildLeadingWidget(BuildContext context) {
    return hideBackButton == true
        ? null
        : GestureDetector(
            onTap: popBackTap ??
                () {
                  /// 隐藏键盘
                  FocusScope.of(context).requestFocus(FocusNode());
                  maybePop(context);
                },
            child: Container(
              color: Colors.transparent,
              width: leadingWidgetWidth,
              height: double.infinity,
              child: Row(
                children: [
                  Container(width: 10),
                  const Icon(Icons.arrow_back_ios),
                ],
              ),
            ),
          );
  }

  @override
  Widget? buildContentWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: title ?? const Text(''),
    );
  }

  @override
  Widget? buildTrailingWidget(BuildContext context) {
    return trailingWidgets.isEmpty
        ? Container(width: trailingWidgetWidth)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: trailingWidgets,
          );
  }
}
