import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarButton extends StatelessWidget {
  final String? title;
  final bool select;
  final int index;
  final Function(TabBarButton) onTap;

  const TabBarButton({
    Key? key,
    required this.select,
    required this.index,
    required this.onTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Text(title!).addDefaultTextStyle(style: TextStyle(fontSize: 26.sp, color: select ? Colors.black : Colors.grey)),
    ).addTapEvent(() => onTap(this));
  }
}
