import 'package:flutter/material.dart';

/// 本地语言的枚举值
enum AppLanguage {
  english,
  chinese,
  japanese,
}

/// 本地语言的枚举值扩展
extension AppLanguageExtension on AppLanguage {
  /// 根据枚举值获取本地语言
  Locale get locale {
    switch (this) {
      case AppLanguage.english:
        return const Locale('en', 'US');
      case AppLanguage.chinese:
        return const Locale('zh', 'CN');
      case AppLanguage.japanese:
        return const Locale('ja', 'JP');
    }
  }

  /// 获取语言所代表的值
  int get code {
    switch (this) {
      case AppLanguage.english:
        return 1;
      case AppLanguage.chinese:
        return 2;
      case AppLanguage.japanese:
        return 3;
    }
  }
}
