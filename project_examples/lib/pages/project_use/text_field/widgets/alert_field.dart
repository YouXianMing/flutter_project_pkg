import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class AlertField {
  /// 初始文本
  final String text;

  /// placeHolder
  final String placeHolder;

  /// 限定文本长度
  final int limitLength;

  /// 文本宽度obs
  final _letterCount = 0.obs;

  /// FocusNode
  FocusNode get focusNode => _focusNode;
  final _focusNode = FocusNode();

  /// 输出文本
  String get inputText => _inputText;
  String _inputText = '';

  AlertField({
    required this.text,
    required this.placeHolder,
    required this.limitLength,
  });

  CustomTextField widget() {
    _inputText = text;

    List<TextInputFormatter> inputFormatters = [];
    if (limitLength > 0) {
      inputFormatters = [LengthLimitingTextInputFormatter(limitLength)];
    }

    _letterCount.value = text.length;

    return CustomTextField(
      focusNode: _focusNode,
      editingController: TextEditingController(text: text),
      isInOverlay: true,
      fieldHeight: 40,
      placeHolder: placeHolder,
      suffixWidget: limitLength <= 0
          ? const SizedBox()
          : Obx(() =>
              WidgetsFactory.text('${_letterCount.value}/$limitLength', fontSize: 14, color: Colors.lightBlue, textAlign: TextAlign.right)
                  .addPaddingOnly(left: 10)),
      margin: const EdgeInsets.only(left: 15, right: 15),
      padding: const EdgeInsets.only(left: 10, right: 10),
      textStyle: const TextStyle(fontSize: 15, color: Colors.black87),
      placeHolderTextStyle: const TextStyle(fontSize: 15, color: Colors.grey),
      inputFormatters: inputFormatters,
      onChanged: (value) {
        _letterCount.value = value.length;
        _inputText = value;
      },
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(width: 1, color: Colors.grey),
      ),
    );
  }
}
