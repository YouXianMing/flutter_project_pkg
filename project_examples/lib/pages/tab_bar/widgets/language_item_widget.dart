import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/languages/app_language.dart';

class LanguageItem {
  bool selected;
  String title;
  AppLanguage appLanguage;

  LanguageItem({required this.selected, required this.title, required this.appLanguage});
}

class LanguageItemWidget extends StatelessWidget {
  final LanguageItem item;
  final Function(LanguageItem item) onTap;

  const LanguageItemWidget({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BgColorButtonWidget(
      highlightedBgColor: HexColor('#f6f6f6'),
      onTap: () => onTap(item),
      child: Container(
        padding: EdgeInsets.all(15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WidgetsFactory.text(item.title),
            _widgetIcon(),
          ],
        ),
      ),
    );
  }

  Widget _widgetIcon() {
    double size = 20.w;
    return AnimatedCrossFade(
      firstChild: Icon(Icons.circle_outlined, size: size, color: Colors.black26),
      secondChild: Icon(Icons.circle, size: size, color: Colors.black87),
      crossFadeState: item.selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }
}
