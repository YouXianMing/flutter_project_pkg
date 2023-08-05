import 'package:project_examples/languages/app_language.dart';

class AppInfo {
  static late AppLanguage _currentLanguage;

  /// 获取当前语言
  static AppLanguage get language => _currentLanguage;

  /// 设置语言
  static void setAppLanguage(AppLanguage language) => _currentLanguage = language;
}
