import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';
import 'package:project_examples/pages/tab_bar/widgets/language_item_widget.dart';

class LanguagePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const LanguagePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AnimatedWidgetPageState();
}

class AnimatedWidgetPageState extends NormalStatefulWidgetState<LanguagePage> {
  final List<LanguageItem> _languageItems = [];
  final _autoObx = AutoObx();

  @override
  void initState() {
    super.initState();

    for (var appLanguage in AppLanguage.values) {
      switch (appLanguage) {
        case AppLanguage.english:
          _languageItems.add(LanguageItem(
            appLanguage: appLanguage,
            selected: AppInfo.language == appLanguage,
            title: '英文'.tr,
          ));
          break;
        case AppLanguage.chinese:
          _languageItems.add(LanguageItem(
            appLanguage: appLanguage,
            selected: AppInfo.language == appLanguage,
            title: '中文'.tr,
          ));
          break;
      }
    }
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget('语言设置'.tr),
      );

  @override
  Widget body(BuildContext context) {
    return _autoObx.buildObx(
      () => WidgetsFactory.listViewBuilder(
        build: ListViewBuilderConfig(
          items: _languageItems,
          builder: (c, i, d) => LanguageItemWidget(
            item: d,
            onTap: (item) {
              // 修改数据源
              for (var element in _languageItems) {
                element.selected = (element == item);
              }

              // 更新翻译 + 存储翻译的值 + 更新语言全局变量
              Get.updateLocale(item.appLanguage.locale);
              AppInt.language.value = item.appLanguage.code;
              AppInfo.setAppLanguage(item.appLanguage);

              // 刷新组件
              _autoObx.manualUpdate();
            },
          ),
        ),
      ),
    );
  }
}
