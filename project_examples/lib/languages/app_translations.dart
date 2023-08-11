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
  'SliverSections的使用': {_zh: 'SliverSections的使用', _en: 'Use of SliverSections'},
  '自定义按钮': {_zh: '自定义按钮', _en: 'Custom Button'},
  '首次加载组件v1': {_zh: '首次加载组件v1', _en: 'Loading components for the first time v1'},
  '首次加载组件v2': {_zh: '首次加载组件v2', _en: 'Loading components for the first time v2'},
  '文件扫描': {_zh: '文件扫描', _en: 'Document scanning'},
  '抽奖': {_zh: '抽奖', _en: 'Lottery'},
  '纸屑效果': {_zh: '纸屑效果', _en: 'Confetti effect'},
  '视差效果': {_zh: '视差效果', _en: 'Parallax effect'},
  '动画基本使用': {_zh: '动画基本使用', _en: 'Animation basics'},
  '组合动画': {_zh: '组合动画', _en: 'Group animation'},
  '分段动画': {_zh: '分段动画', _en: 'Tween sequence animation'},
  'AnimatedWidget使用': {_zh: 'AnimatedWidget使用', _en: 'Use of AnimatedWidget'},
  'AnimationsManager的使用': {_zh: 'AnimationsManager的使用', _en: 'Use of AnimationsManager'},
  'AnimationsManager的重复使用': {_zh: 'AnimationsManager的重复使用', _en: 'Reuse of AnimationsManager'},
  'AnimationsManager的Curves': {_zh: 'AnimationsManager的Curves', _en: 'AnimationsManager\'s Curves'},
  'AnimationsManager与Interval配合使用': {_zh: 'AnimationsManager与Interval配合使用', _en: 'AnimationsManager works with Interval'},
  'AnimationsManager与Sequence配合使用': {_zh: 'AnimationsManager与Sequence配合使用', _en: 'AnimationsManager works with Sequence'},
  '添加购物车动画': {_zh: '添加购物车动画', _en: 'Add cart animation'},
  'async 与 await': {_zh: 'async 与 await', _en: 'async and await'},
  'Dart的事件循环': {_zh: 'Dart的事件循环', _en: 'Dart\'s event loop'},
};
