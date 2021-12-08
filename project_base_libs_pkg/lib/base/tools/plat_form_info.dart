import 'dart:io' as p;
import 'package:flutter/foundation.dart';

class PlatFormInfo {
  /// 是否是iOS平台(使用kIsWeb提前校验是为了兼容全平台,web平台调用Platform的相关方法会崩溃)
  static bool get isIOS => kIsWeb ? false : p.Platform.isIOS;

  /// 是否是安卓平台(使用kIsWeb提前校验是为了兼容全平台,web平台调用Platform的相关方法会崩溃)
  static bool get isAndroid => kIsWeb ? false : p.Platform.isAndroid;

  /// 是否是Linux平台(使用kIsWeb提前校验是为了兼容全平台,web平台调用Platform的相关方法会崩溃)
  static bool get isLinux => kIsWeb ? false : p.Platform.isLinux;

  /// 是否是MacOS平台(使用kIsWeb提前校验是为了兼容全平台,web平台调用Platform的相关方法会崩溃)
  static bool get isMacOS => kIsWeb ? false : p.Platform.isMacOS;

  /// 是否是Windows平台(使用kIsWeb提前校验是为了兼容全平台,web平台调用Platform的相关方法会崩溃)
  static bool get isWindows => kIsWeb ? false : p.Platform.isWindows;

  /// 是否是Web平台
  static bool get isWeb => kIsWeb;
}
