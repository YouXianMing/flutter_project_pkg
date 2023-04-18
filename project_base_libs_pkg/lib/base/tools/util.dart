import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class Util {
  /// assets下默认的图片地址,可以通过Util.assertsImagePath方法直接设置
  static String _assetsImagePath = 'lib/images/';

  /// assets下默认的资源文件地址,可以通过Util.assertsFilePath方法直接设置
  static String _assetsFilePath = 'lib/assets/';

  /// 设置assetsImagePath(需要设置assertsImagePath,如果没设置,默认为lib/images/)
  static set assertsImagePath(String val) => _assetsImagePath = val;

  /// 设置assetsFilePath(需要设置assertsImagePath,如果没设置,默认为lib/assets/)
  static set assertsFilePath(String val) => _assetsFilePath = val;

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
      maxLength = max(maxLength, textWidthWithTextStyle(element.string, element.style, direction: element?.direction));
    }
    return maxLength;
  }

  /// 便捷的获取asset中的图片文件,只需要给定文件名即可
  /// 注意:可以通过 assertsImagePath 设置asset的根目录,默认值是lib/images/
  static Image image(String name, {Key? key, double? scale, double? width, double? height, BoxFit? fit, Color? color}) => Image.asset(
        _assetsImagePath + name,
        key: key,
        scale: scale,
        width: width,
        height: height,
        fit: fit,
        color: color,
      );

  /// 便捷的获取asset中的文件,只需要给定文件名即可
  /// 注意:可以通过 assertsFilePath 设置asset的根目录,默认值是lib/assets/
  static Future<ByteData> assetByteData({required String name}) => rootBundle.load(_assetsFilePath + name);

  /// 便捷的获取asset中的文件,只需要给定文件名即可
  /// 注意:可以通过 assertsFilePath 设置asset的根目录,默认值是lib/assets/
  static Future<ImmutableBuffer> assetImmutableBuffer({required String name}) => rootBundle.loadBuffer(_assetsFilePath + name);

  /// 便捷的获取asset中的文件,只需要给定文件名即可
  /// 注意:可以通过 assertsFilePath 设置asset的根目录,默认值是lib/assets/
  static Future<String> assetString({required String name, bool cache = true}) =>
      rootBundle.loadString(_assetsFilePath + name, cache: cache);

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

  /// 获取uri的参数
  /// 如果参数uri有问题,则直接返回null
  /// uri可以为文件类型如'/home/myself/data/image',域名类型如'https://www.baidu.com'等,详情可以参考https://api.dart.dev/stable/2.17.6/dart-core/Uri-class.html
  static Map<String, String>? getUriQueryParameters(String uri) => Uri.tryParse(uri)?.queryParameters;
}

class CalculateText {
  final String string;
  final TextStyle style;
  final TextDirection direction;

  const CalculateText(this.string, this.style, {this.direction = TextDirection.ltr});
}
