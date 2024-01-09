import 'package:project_base_libs_pkg/third_lib_get.dart';

const String _zh = 'z';
const String _en = 'e';
const String _jp = 'j';

/// GetX的语言翻译AppTranslations
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    Map<String, String> en = {};
    Map<String, String> zh = {};
    Map<String, String> jp = {};
    for (var key in _translations.keys) {
      en[key] = _translations[key][_en];
      zh[key] = _translations[key][_zh];
      jp[key] = _translations[key][_jp];
    }

    return {
      'en_US': en,
      'zh_CN': zh,
      'ja_JP': jp,
    };
  }
}

const Map<String, dynamic> _translations = {
  'tab_首页': {
    _zh: '首页',
    _en: 'Home',
    _jp: '表紙',
  },
  'tab_类目': {
    _zh: '类目',
    _en: 'Category',
    _jp: 'カテゴリー',
  },
  'tab_购物车': {
    _zh: '购物车',
    _en: 'Cart',
    _jp: '買い物',
  },
  'tab_账户': {
    _zh: '账户',
    _en: 'Account',
    _jp: 'アカウント',
  },
  '第三方库': {
    _zh: '第三方库',
    _en: 'Third libs',
    _jp: 'サードパーティのライブラリ',
  },
  '项目用库': {
    _zh: '项目用库',
    _en: 'Project use libs',
    _jp: 'プロジェクトライブラリ',
  },
  '动画': {
    _zh: '动画',
    _en: 'Animation',
    _jp: 'アニメーション',
  },
  '异步编程': {
    _zh: '异步编程',
    _en: 'Asynchronous programming',
    _jp: '実践的なヒント',
  },
  '实用技巧': {
    _zh: '实用技巧',
    _en: 'Practical Tips',
    _jp: '非同期プログラミング',
  },
  '语言设置': {
    _zh: '语言设置',
    _en: 'Language settings',
    _jp: '言語設定',
  },
  '英文': {
    _zh: 'English',
    _en: 'English',
    _jp: 'English',
  },
  '中文': {
    _zh: '中文',
    _en: '中文',
    _jp: '中文',
  },
  '日文': {
    _zh: '日本語',
    _en: '日本語',
    _jp: '日本語',
  },
  'SliverSections的使用': {
    _zh: 'SliverSections的使用',
    _en: 'Use of SliverSections',
    _jp: 'SliverSection の使用',
  },
  '自定义按钮': {
    _zh: '自定义按钮',
    _en: 'Custom Button',
    _jp: 'カスタムボタン',
  },
  '首次加载组件v1': {
    _zh: '首次加载组件v1',
    _en: 'Loading components for the first time v1',
    _jp: 'コンポーネント v1 を初めてロードする',
  },
  '首次加载组件v2': {
    _zh: '首次加载组件v2',
    _en: 'Loading components for the first time v2',
    _jp: 'コンポーネント v2 を初めてロードする',
  },
  '文件扫描': {
    _zh: '文件扫描',
    _en: 'Document scanning',
    _jp: 'ファイルスキャン',
  },
  '抽奖': {
    _zh: '抽奖',
    _en: 'Lottery',
    _jp: '宝くじ',
  },
  '纸屑效果': {
    _zh: '纸屑效果',
    _en: 'Confetti effect',
    _jp: '紙吹雪効果',
  },
  '视差效果': {
    _zh: '视差效果',
    _en: 'Parallax effect',
    _jp: '視差効果',
  },
  '动画基本使用': {
    _zh: '动画基本使用',
    _en: 'Animation basics',
    _jp: 'アニメーションの基本的な使い方',
  },
  '组合动画': {
    _zh: '组合动画',
    _en: 'Group animation',
    _jp: '組み合わせアニメーション',
  },
  '分段动画': {
    _zh: '分段动画',
    _en: 'Tween sequence animation',
    _jp: 'セグメント化されたアニメーション',
  },
  'AnimatedWidget使用': {
    _zh: 'AnimatedWidget使用',
    _en: 'Use of AnimatedWidget',
    _jp: 'アニメーションウィジェットの使用法',
  },
  'AnimationsManager的使用': {
    _zh: 'AnimationsManager的使用',
    _en: 'Use of AnimationsManager',
    _jp: 'アニメーションマネージャーの使用',
  },
  'AnimationsManager的重复使用': {
    _zh: 'AnimationsManager的重复使用',
    _en: 'Reuse of AnimationsManager',
    _jp: 'アニメーションマネージャーの再利用',
  },
  'AnimationsManager的Curves': {
    _zh: 'AnimationsManager的Curves',
    _en: 'AnimationsManager\'s Curves',
    _jp: 'アニメーションの曲線マネージャー',
  },
  'AnimationsManager与Interval配合使用': {
    _zh: 'AnimationsManager与Interval配合使用',
    _en: 'AnimationsManager works with Interval',
    _jp: 'アニメーションマネージャーはインターバルで動作します',
  },
  'AnimationsManager与Sequence配合使用': {
    _zh: 'AnimationsManager与Sequence配合使用',
    _en: 'AnimationsManager works with Sequence',
    _jp: 'アニメーションマネージャーはシーケンスと連動します',
  },
  '添加购物车动画': {
    _zh: '添加购物车动画',
    _en: 'Add cart animation',
    _jp: 'ショッピングカートのアニメーションを追加する',
  },
  'async 与 await': {
    _zh: 'async 与 await',
    _en: 'async and await',
    _jp: '非同期で待機する',
  },
  'Dart的事件循环': {
    _zh: 'Dart的事件循环',
    _en: 'Dart\'s event loop',
    _jp: 'ダーツのイベントループ',
  },
  '更新数据': {
    _zh: '更新数据',
    _en: 'Update data',
    _jp: 'データを更新する',
  },
  '重置': {
    _zh: '重置',
    _en: 'Reset',
    _jp: 'リセット',
  },
  '刮开': {
    _zh: '刮开',
    _en: 'Scrape open',
    _jp: 'こすって開ける',
  },
  '正面': {
    _zh: '正面',
    _en: 'Front',
    _jp: 'フロント',
  },
  '反面': {
    _zh: '反面',
    _en: 'Reverse side',
    _jp: '裏',
  },
  '翻转': {
    _zh: '翻转',
    _en: 'Flip',
    _jp: 'フリップ',
  },
  '随机角度': {
    _zh: '随机角度',
    _en: 'Random angle',
    _jp: 'ランダムな角度',
  },
  '暗示(该控件可以翻转)': {
    _zh: '暗示(该控件可以翻转)',
    _en: 'Hint (the widget can be flipped)',
    _jp: 'ヒント（コントロールは反転可能）',
  },
  'SliverSectionTip1': {
    _zh: 'SliverWaterfallFlowSection.builder (点击我)',
    _en: 'SliverWaterfallFlowSection.builder (Tap me)',
    _jp: 'SliverWaterfallFlowSection.builder (クリックしてください)',
  },
  'SliverSectionTip2': {
    _zh: 'SliverStaggeredGridCountBuilderSection\n瀑布流不建议使用此控件的sliver版本,有bug',
    _en: 'SliverStaggeredGridCountBuilderSection\nIt is not recommended to use the sliver version, It has bugs.',
    _jp: 'SliverStaggeredGridCountBuilderSection\nスライバー バージョンにはバグがあるため、使用はお勧めしません。',
  },
  'readMoreTip': {
    _zh:
        '拜登政府5月曾下令让美国情报部门在90天内提交一份新冠病毒源头调查报告。所以，美国情报部门，3个月内你们真的能完成吗？美国一些政客试图用政治手段来回答这样一个科学问题，那么问题来了，如果用“政治编造”+“谎言污蔑”造出这样一份溯源调查报告，会有人相信吗？美国情报部门，请回答！(记者 冰洁 摄像 王潮 制作 周璟 技术 杨思雨 孙红卫）',
    _en:
        'In May, the Biden administration ordered the U.S. intelligence agency to submit a report on the investigation into the origins of the new coronavirus within 90 days. So, U.S. intelligence agencies, can you really complete it in 3 months? Some politicians in the United States are trying to use political means to answer such a scientific question. So the question is, if "political fabrication" + "lies and slander" are used to create such a traceability investigation report, will anyone believe it? U.S. Intelligence, please answer! (Reporter Bing Jie, videography, Wang Chao, production, Zhou Jing, technology, Yang Siyu, Sun Hongwei)',
    _jp: 'SliverStaggeredGridCountBuilderSection\nスライバー バージョンにはバグがあるため、使用はお勧めしません。',
  },
  '数据': {
    _zh: '数据',
    _en: 'Data',
    _jp: 'データ',
  },
  '点击我': {
    _zh: '点击我',
    _en: 'Tap me',
    _jp: 'クリックしてください',
  },
  '点击更新': {
    _zh: '点击更新',
    _en: 'Click to update',
    _jp: 'クリックして更新',
  },
  '点击重试': {
    _zh: '点击重试',
    _en: 'Click to try again',
    _jp: 'クリックして再試行してください',
  },
  '很抱歉,出错啦': {
    _zh: '很抱歉,出错啦',
    _en: 'Sorry, something went wrong',
    _jp: '申し訳ありませんが、問題が発生しました',
  },
  '等待中': {
    _zh: '等待中',
    _en: 'Waiting',
    _jp: '待っている',
  },
  '结果': {
    _zh: '结果',
    _en: 'Result',
    _jp: '結果',
  },
  '开始': {
    _zh: '开始',
    _en: 'Start',
    _jp: '始める',
  },
  '运行中': {
    _zh: '运行中',
    _en: 'Running',
    _jp: 'ランニング',
  },
  '结束': {
    _zh: '结束',
    _en: 'Finish',
    _jp: '仕上げる',
  },
  '展开': {
    _zh: '展开',
    _en: 'Expand',
    _jp: '拡大する',
  },
  '收起': {
    _zh: ' 收起',
    _en: ' Close',
    _jp: ' 近い',
  },
};
