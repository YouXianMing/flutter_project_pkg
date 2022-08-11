import 'dart:async';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class Util {
  /// https://pub.flutter-io.cn/packages/english_words
  static WordPair get randomWordPair => WordPair.random();

  static String get randomWordPairAsString => WordPair.random().asString;

  static String get randomWordPairAsLowerCase => WordPair.random().asLowerCase;

  static String get randomWordPairAsSnakeCase => WordPair.random().asSnakeCase;

  static String get randomWordPairAsPascalCase => WordPair.random().asPascalCase;

  static String get randomWordPairAsCamelCase => WordPair.random().asCamelCase;

  static String get randomWordPairAsUpperCase => WordPair.random().asUpperCase;

  /// 随机色(透明度也是随机的)
  static Color get randomColor => Color(Random().nextInt(0xffffffff));

  /// 随机色
  static Color get randomOpaqueColor => Color(Random().nextInt(0xffffffff)).withAlpha(0xff);

  /// 随机double
  static double randomDouble({int min = 0, required int max}) {
    if (max == min) return max.toDouble();
    assert(min - max < 0);
    return (min + Random().nextInt(max - min)).toDouble();
  }

  /// 随机int
  static int randomInt({int min = 0, required int max}) {
    if (max == min) return max;
    assert(min - max < 0);
    return min + Random().nextInt(max - min);
  }

  /// 随机bool
  static bool get randomBool => Random().nextBool();

  /// 随机小数(0 ~ 1.0)
  static double get randomPercent => Random().nextDouble();

  /// 从给定的数组里获取随机的对象,如果index设置了值,则获取指定位置的对象
  static T randomObjectFromList<T>(List<T> list, {int? index}) {
    if (index != null) {
      return list[index];
    } else {
      return list[Random().nextInt(list.length)];
    }
  }

  /// 计算文本宽度
  static double textWidthWithTextStyle(String string, TextStyle style, {TextDirection direction = TextDirection.ltr}) {
    final TextPainter textPainter = TextPainter(text: TextSpan(text: string, style: style), maxLines: 1, textDirection: direction)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

  /// 文本数组中的最大的宽度
  static double maxWidthWithTexts(List<CalculateText> list) {
    double maxLength = 0;
    for (dynamic element in list) {
      maxLength = max(maxLength, textWidthWithTextStyle(element.string, element.style, direction: element?.direction ?? TextDirection.ltr));
    }
    return maxLength;
  }

  /// 获取图片(需要设置assertsImagePath,如果没设置,默认为lib/images/)
  static set assertsImagePath(String val) => _assetsImagePath = val;
  static String _assetsImagePath = 'lib/images/';

  static Image image(String name, {Key? key, double? scale, double? width, double? height, BoxFit? fit, Color? color}) => Image.asset(
        _assetsImagePath + name,
        key: key,
        scale: scale,
        width: width,
        height: height,
        fit: fit,
        color: color,
      );

  /// 延时毫秒
  static Future<T> delayedMilliseconds<T>(int milliseconds, FutureOr<T> Function()? computation) =>
      Future.delayed(Duration(milliseconds: milliseconds), computation);

  /// 延时秒
  static Future<T> delayedSeconds<T>(int seconds, FutureOr<T> Function()? computation) =>
      Future.delayed(Duration(seconds: seconds), computation);

  /// 获取秒时间戳
  static int get secondsTimestamp => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  /// 获取毫秒时间戳
  static int get millisecondsTimestamp => DateTime.now().millisecondsSinceEpoch;

  /// 获取微秒时间戳
  static int get microsecondsTimestamp => DateTime.now().microsecondsSinceEpoch;
}

class CalculateText {
  String string;
  TextStyle style;
  TextDirection? direction;

  CalculateText(this.string, this.style, {this.direction});
}
