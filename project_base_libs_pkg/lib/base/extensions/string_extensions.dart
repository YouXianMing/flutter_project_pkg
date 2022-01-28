import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

extension StringExtensions on String {
  // crypto: ^3.0.1
  String get md5String => md5.convert(const Utf8Encoder().convert(this)).toString();
  String get sha1String => sha1.convert(const Utf8Encoder().convert(this)).toString();
  String get sha224String => sha224.convert(const Utf8Encoder().convert(this)).toString();
  String get sha256String => sha256.convert(const Utf8Encoder().convert(this)).toString();
  String get sha384String => sha384.convert(const Utf8Encoder().convert(this)).toString();
  String get sha512String => sha512.convert(const Utf8Encoder().convert(this)).toString();
  String get sha512224String => sha512224.convert(const Utf8Encoder().convert(this)).toString();
  String get sha512256String => sha512256.convert(const Utf8Encoder().convert(this)).toString();

  /// 计算文本宽度
  double widthWithTextStyle(TextStyle style, {TextDirection direction = TextDirection.ltr}) {
    final TextPainter textPainter = TextPainter(text: TextSpan(text: this, style: style), maxLines: 1, textDirection: direction)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }
}

extension StringRegExpExtensions on String {
  /// 通过正则表达式匹配并返回匹配到的字符串数组
  List<String> regExpMatchStringList(
      {required String pattern, bool multiLine = false, bool caseSensitive = true, bool unicode = false, bool dotAll = false}) {
    Iterable<RegExpMatch> matches =
        RegExp(pattern, multiLine: multiLine, caseSensitive: caseSensitive, unicode: unicode, dotAll: dotAll).allMatches(this);
    List<String> list = [];
    for (var value in matches) {
      list.add(substring(value.start, value.end));
    }
    return list;
  }

  /// 通过正则表达式匹配并返回匹配的结果
  Iterable<RegExpMatch> regExpMatches(
      {required String pattern, bool multiLine = false, bool caseSensitive = true, bool unicode = false, bool dotAll = false}) {
    return RegExp(pattern, multiLine: multiLine, caseSensitive: caseSensitive, unicode: unicode, dotAll: dotAll).allMatches(this);
  }

  /// 通过正则表达式替换字符串
  String regExpReplace(
      {required String pattern,
      required String source,
      bool multiLine = false,
      bool caseSensitive = true,
      bool unicode = false,
      bool dotAll = false}) {
    return replaceAllMapped(
        RegExp(pattern, multiLine: multiLine, caseSensitive: caseSensitive, unicode: unicode, dotAll: dotAll), (match) => source);
  }

  /// 通过正则表达式替换字符串
  String regExpReplaceMatches(
      {required String pattern,
      required String Function(Match match) replace,
      bool multiLine = false,
      bool caseSensitive = true,
      bool unicode = false,
      bool dotAll = false}) {
    return replaceAllMapped(RegExp(pattern, multiLine: multiLine, caseSensitive: caseSensitive, unicode: unicode, dotAll: dotAll), replace);
  }
}
