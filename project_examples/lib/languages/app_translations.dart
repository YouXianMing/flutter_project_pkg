import 'package:project_base_libs_pkg/third_lib_get.dart';

const String _zh = 'z';
const String _en = 'e';

/// GetX的语言翻译AppTranslations
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    Map<String, String> en = {};
    Map<String, String> zh = {};
    for (var key in _translations.keys) {
      en[key] = _translations[key][_en];
      zh[key] = _translations[key][_zh];
    }

    return {'en_US': en, 'zh_CN': zh};
  }
}

const Map<String, dynamic> _translations = {
  'tab_首页': {_zh: '首页', _en: 'Home'},
  'tab_类目': {_zh: '类目', _en: 'Category'},
  'tab_购物车': {_zh: '购物车', _en: 'Cart'},
  'tab_账户': {_zh: '账户', _en: 'Account'},
  '第三方库': {_zh: '第三方库', _en: 'Third libs'},
  '项目用库': {_zh: '项目用库', _en: 'Project use libs'},
  '动画': {_zh: '动画', _en: 'Animation'},
  '异步编程': {_zh: '异步编程', _en: 'Asynchronous programming'},
  '语言设置': {_zh: '语言设置', _en: 'Language settings'},
  '英文': {_zh: 'English', _en: 'English'},
  '中文': {_zh: '中文', _en: '中文'},
};
