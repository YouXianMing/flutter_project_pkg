import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

enum DatePickerLocale {
  /// 中文
  chinese,

  /// 英文
  english,
}

class DatePickerWidget extends StatelessWidget {
  /// 每个条目的高度,默认50
  final double itemExtent;

  /// 组件高度,默认200
  final double height;

  /// 滑动选项后联动选项返回到初始位置
  final bool changeToFirst;

  /// 开始年份,默认1970
  final int yearBegin;

  /// 结束年份,默认2100
  final int yearEnd;

  /// 未选中文本样式
  final TextStyle? textStyle;

  /// 选中文本样式
  final TextStyle? selectedTextStyle;

  /// 初始指定时间(如果为空,则设定为当前日期)
  final DateTime? initDate;

  /// 语言,默认英文
  final DatePickerLocale locale;

  /// 当前选中日期
  final Function(DateTime?) onSelect;

  const DatePickerWidget({
    super.key,
    this.itemExtent = 50,
    this.height = 200,
    this.changeToFirst = true,
    this.textStyle,
    this.selectedTextStyle,
    this.yearBegin = 1970,
    this.yearEnd = 2100,
    this.initDate,
    this.locale = DatePickerLocale.english,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    List<String>? months;
    String? daySuffix;
    String? yearSuffix;
    switch (locale) {
      case DatePickerLocale.chinese:
        daySuffix = '日';
        yearSuffix = '年';
        months = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
        break;
      case DatePickerLocale.english:
        months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        break;
    }

    return Picker(
      hideHeader: true,
      height: height,
      itemExtent: itemExtent,
      changeToFirst: changeToFirst,
      selectedTextStyle: selectedTextStyle,
      textStyle: textStyle,
      selectionOverlay: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(color: const Color(0xFFD6D6D6), height: 1),
          Container(color: const Color(0xFFD6D6D6), height: 1),
        ],
      ),
      adapter: DateTimePickerAdapter(
        value: initDate,
        type: PickerDateTimeType.kYMD,
        months: months,
        yearBegin: yearBegin,
        yearEnd: yearEnd,
        daySuffix: daySuffix,
        yearSuffix: yearSuffix,
      ),
      onSelect: (Picker picker, int index, List value) => onSelect((picker.adapter as DateTimePickerAdapter).value),
    ).makePicker();
  }
}
