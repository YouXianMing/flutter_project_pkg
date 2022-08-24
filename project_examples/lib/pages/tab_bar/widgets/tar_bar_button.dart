import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool select;
  final int index;
  final Function(TabBarButton) onTap;

  const TabBarButton({
    Key? key,
    required this.title,
    required this.iconData,
    required this.select,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Colors.black;
    Color unSelectedColor = Colors.grey;
    Duration duration = const Duration(milliseconds: 250);

    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            child: AnimatedCrossFade(
              firstChild: Icon(iconData, color: selectedColor),
              secondChild: Icon(iconData, color: unSelectedColor),
              crossFadeState: select ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: duration,
            ),
          ),
          WidgetsFactory.animatedText(title, fontSize: 22.sp, color: select ? selectedColor : unSelectedColor, duration: duration),
        ],
      ),
    ).addTapEvent(() => onTap(this));
  }
}
