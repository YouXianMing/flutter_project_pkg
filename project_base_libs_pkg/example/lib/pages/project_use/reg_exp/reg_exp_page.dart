import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class RegExpPage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const RegExpPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _RegExpPageState();
}

class _RegExpPageState extends NormalStatefulWidgetState<RegExpPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) =>
      NormalAppBar(context: context, title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''));

  @override
  Widget body(BuildContext context) {
    String str = 'Parse my string';
    appPrint(str.regExpMatchStringList(pattern: r'\w+'));
    for (var value in str.regExpMatches(pattern: r'\w+')) {
      appPrint(value.input.substring(value.start, value.end));
    }
    appPrint(str.regExpReplace(pattern: r'\w+', source: '10000'));
    appPrint(str.regExpReplaceMatches(
        pattern: r'\w+',
        replace: (match) {
          String tmp = match.input.substring(match.start, match.end);
          return tmp == 'string' ? 'XX' : tmp;
        }));

    return const Center(child: Text('查看打印信息'));
  }
}
