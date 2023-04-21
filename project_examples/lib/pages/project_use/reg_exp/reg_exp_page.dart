import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class RegExpPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const RegExpPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => RegExpPageState();
}

class RegExpPageState extends NormalStatefulWidgetState<RegExpPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    String str = 'Parse my string';
    // 通过正则表达式匹配并返回匹配到的字符串数组
    appPrint(str.regExpMatchStringList(pattern: r'\w+'));

    // 通过正则表达式匹配并返回匹配的结果
    for (var value in str.regExpMatches(pattern: r'\w+')) {
      appPrint(value.input.substring(value.start, value.end));
    }

    // 通过正则表达式替换字符串
    appPrint(str.regExpReplace(pattern: r'\w+', source: '10000'));

    // 通过正则表达式替换字符串
    appPrint(str.regExpReplaceMatches(
        pattern: r'\w+',
        replace: (match) {
          String tmp = match.input.substring(match.start, match.end);
          return tmp == 'string' ? 'XX' : tmp;
        }));

    return const Center(child: Text('查看打印信息'));
  }
}
