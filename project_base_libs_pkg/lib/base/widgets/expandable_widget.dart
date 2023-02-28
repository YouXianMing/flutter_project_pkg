import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableWidget extends StatelessWidget {
  /// 子控件
  final Widget child;

  /// 是否展开
  final bool expanded;

  /// theme设置
  final ExpandableThemeData? theme;

  const ExpandableWidget({Key? key, required this.child, required this.expanded, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expandable(
      controller: ExpandableController(initialExpanded: expanded),
      collapsed: const SizedBox(width: double.infinity),
      theme: theme,
      expanded: child,
    );
  }
}
