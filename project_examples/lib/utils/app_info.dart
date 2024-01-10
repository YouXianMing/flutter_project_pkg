import 'package:flutter/rendering.dart';
import 'package:project_examples/languages/app_language.dart';

class AppInfo {
  /// 当前语言
  static late AppLanguage _currentLanguage;

  /// 屏幕padding
  static EdgeInsets _screenPadding = EdgeInsets.zero;

  /// 获取当前语言
  static AppLanguage get language => _currentLanguage;

  /// 获取屏幕padding
  static EdgeInsets get screenPadding => _screenPadding;

  /// 设置语言
  static void setAppLanguage(AppLanguage language) => _currentLanguage = language;

  /// 设置ScreenPadding的参数
  static void setScreenPadding(EdgeInsets edgeInsets) {
    // 防止后续设置成0了
    if (_screenPadding.bottom > 0 && edgeInsets.bottom <= 0) {
      return;
    }
    _screenPadding = edgeInsets;
  }
}
