import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 自定义TextField
class CustomTextField extends StatelessWidget {
  /// 输入文本的style
  final TextStyle textStyle;

  /// placeHolder的style
  final TextStyle placeHolderTextStyle;

  /// TextField的decoration
  final Decoration decoration;

  /// 前缀控件
  final Widget? prefixWidget;

  /// 后缀控件
  final Widget? suffixWidget;

  /// TextField的高度,如果不设置值,则为TextField的默认高度
  final double? fieldHeight;

  /// placeHolder
  final String placeHolder;

  /// 输入格式设定
  final List<TextInputFormatter>? inputFormatters;

  /// 键盘类型
  final TextInputType? keyboardType;

  /// textField的key（有多个TextField控件时用来给filed做标记）
  final Key? textFieldKey;

  /// 实时读取值的回调
  final ValueChanged<String>? onChanged;

  /// 是否启用TextField
  final bool enableTextField;

  /// TextField的控制器
  final TextEditingController? editingController;

  /// padding
  final EdgeInsets? padding;

  /// margin
  final EdgeInsets? margin;

  /// 是否在overlay上(如果在overlay上,则TextField会被Material包裹)
  final bool isInOverlay;

  /// 自动开启键盘,默认值为false
  final bool autofocus;

  /// 开启键盘的节点(调用myFocusNode.requestFocus()来启动键盘)
  final FocusNode? focusNode;

  const CustomTextField({
    Key? key,
    required this.textStyle,
    required this.placeHolderTextStyle,
    required this.decoration,
    this.prefixWidget,
    this.suffixWidget,
    this.fieldHeight,
    this.placeHolder = '',
    this.inputFormatters,
    this.keyboardType,
    this.textFieldKey,
    this.onChanged,
    this.enableTextField = true,
    this.editingController,
    this.padding,
    this.margin,
    this.isInOverlay = false,
    this.autofocus = false,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fieldHeight,
      decoration: decoration,
      padding: padding,
      margin: margin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          prefixWidget ?? const SizedBox(width: 0),
          Expanded(
            child: isInOverlay ? Material(color: Colors.transparent, child: _textField()) : _textField(),
          ),
          suffixWidget ?? const SizedBox(width: 0),
        ],
      ),
    );
  }

  Widget _textField() => TextField(
        autofocus: autofocus,
        focusNode: focusNode,
        controller: editingController,
        enabled: enableTextField,
        key: textFieldKey,
        onChanged: onChanged,
        style: textStyle,
        maxLines: 1,
        decoration: InputDecoration(hintText: placeHolder, hintStyle: placeHolderTextStyle, border: InputBorder.none),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      );
}
