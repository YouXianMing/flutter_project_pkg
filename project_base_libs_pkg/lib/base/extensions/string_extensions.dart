import 'dart:convert';
import 'package:change_case/change_case.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

extension StringExtensions on String {
  /// 计算文本宽度
  double widthWithTextStyle(TextStyle style, {TextDirection direction = TextDirection.ltr}) {
    final TextPainter textPainter = TextPainter(text: TextSpan(text: this, style: style), maxLines: 1, textDirection: direction)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }
}

// https://pub.dev/packages/change_case
extension StringChangeCaseExtensions on String {
  /// 'hello_world' -> 'helloWorld'
  String get camelCaseString => toCamelCase();

  /// 'hello world' -> 'Hello World'
  String get capitalCaseString => toCapitalCase();

  /// 'hello world' -> 'HELLO_WORLD'
  String get constantCaseString => toConstantCase();

  /// 'hello World' -> 'hello.world'
  String get dotCaseString => toDotCase();

  /// 'hello world' -> 'Hello-World'
  String get headerCaseString => toHeaderCase();

  /// 'Hello-World' -> 'hello world'
  String get noCaseString => toNoCase();

  /// 'hello World' -> 'hello-world'
  String get paramCaseString => toParamCase();

  /// 'hello_world' -> 'HelloWorld'
  String get pascalCaseString => toPascalCase();

  /// 'hello World' -> 'hello/world'
  String pathCaseString([String? separator]) => toPathCase(separator);

  /// 'hello World' -> 'Hello world'
  String get sentenceCaseString => toSentenceCase();

  /// 'hello World' -> 'hello_world'
  String get snakeCaseString => toSnakeCase();

  /// 'hello world' -> 'Hello World'
  String get titleCaseString => toTitleCase();

  /// 'Hello World' -> 'hELLO wORLD'
  String get swapCaseString => toSwapCase();
}

// https://pub.flutter-io.cn/packages/crypto
extension StringCrytoExtensions on String {
  String get md5String => md5.convert(const Utf8Encoder().convert(this)).toString();

  String get sha1String => sha1.convert(const Utf8Encoder().convert(this)).toString();

  String get sha224String => sha224.convert(const Utf8Encoder().convert(this)).toString();

  String get sha256String => sha256.convert(const Utf8Encoder().convert(this)).toString();

  String get sha384String => sha384.convert(const Utf8Encoder().convert(this)).toString();

  String get sha512String => sha512.convert(const Utf8Encoder().convert(this)).toString();

  String get sha512224String => sha512224.convert(const Utf8Encoder().convert(this)).toString();

  String get sha512256String => sha512256.convert(const Utf8Encoder().convert(this)).toString();
}

extension StringPathExtensions on String {
  /// 获取字符串路径的后缀名
  String pathExtension({int level = 1}) => p.extension(this, level);

  /// 获取字符串路径的文件夹名字
  String get pathDirName => p.dirname(this);

  /// 获取字符串路径的文件名字
  String get pathBaseName => p.basename(this);

  /// 获取字符串路径的文件名字,不带后缀名字
  String get pathBasenameWithoutExtension => p.basenameWithoutExtension(this);

  /// 获取字符串路径的分割后的数组
  List<String> get pathSplit => p.split(this);
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
