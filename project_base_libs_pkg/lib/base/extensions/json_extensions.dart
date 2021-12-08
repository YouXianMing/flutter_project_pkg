import 'dart:convert';

extension ObjectJsonExtensions on Object {
  /// 获取JsonString
  String get jsonString => jsonEncode(this);
}

extension ObjectStringExtensions on String {
  /// 获取json对象
  dynamic get jsonObject => jsonDecode(this);
}
