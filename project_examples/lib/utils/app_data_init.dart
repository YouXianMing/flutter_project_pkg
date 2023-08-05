import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/languages/app_language.dart';
import 'package:project_examples/utils/app_enum_cache.dart';
import 'dart:ui' as ui;
import 'package:project_examples/utils/app_info.dart';

class AppDataInit {
  static Future start() async {
    // spVal的初始化
    await SpVal.initialized();

    // 设置语言相关
    int code = AppInt.language.value;
    if (code == 0) {
      // code为0,表示是初次设置语言,先判断用户系统语言,如果包含了zh,则设置成中文,如果不包含,则设置成英文
      if (ui.window.locale.languageCode.toLowerCase().contains('zh')) {
        AppInt.language.value = AppLanguage.chinese.code;
        AppInfo.setAppLanguage(AppLanguage.chinese);
      } else {
        AppInt.language.value = AppLanguage.english.code;
        AppInfo.setAppLanguage(AppLanguage.english);
      }
    } else {
      // code不为0,则表示本地存储了语言相关的值,读取设置即可
      for (var language in AppLanguage.values) {
        if (code == language.code) AppInfo.setAppLanguage(language);
      }
    }
  }
}
