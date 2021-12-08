import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateless_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

enum AppString { userId, info }
enum AppInt { userAge }
enum AppDouble { score }

extension AppStringExtension on AppString {
  String get value => SpVal.get(SpString(key: toString()));
  set value(String val) => SpVal.set(SpString(key: toString(), value: val));
}

extension AppIntExtension on AppInt {
  int get value => SpVal.get(SpInt(key: toString()));
  set value(int val) => SpVal.set(SpInt(key: toString(), value: val));
}

extension AppDoubleExtension on AppDouble {
  double get value => SpVal.get(SpDouble(key: toString()));
  set value(double val) => SpVal.set(SpDouble(key: toString(), value: val));
}

class SpValPage extends NormalStatelessWidget {
  final PageArguments? arguments;
  final ToastWidget toastWidget = ToastWidget();

  SpValPage({Key? key, this.arguments}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(arguments?.mark ?? ''),
      );

  @override
  Widget body(BuildContext context) {
    AppString.userId.value = Util.randomWordPairAsCamelCase;
    AppString.info.value = {'address': 'BeiJing'}.jsonString;
    AppInt.userAge.value = Util.randomInt(min: 16, max: 34);
    AppDouble.score.value = Util.randomDouble(min: 60, max: 100);

    return CustomScrollView(
      slivers: [
        SliverListSection.staticTypeWidget(children: [
          Text(AppString.userId.value).addPadding(const EdgeInsets.all(10)),
          Text(AppString.info.value).addPadding(const EdgeInsets.all(10)),
          Text(AppInt.userAge.value.toString()).addPadding(const EdgeInsets.all(10)),
          Text(AppDouble.score.value.toString()).addPadding(const EdgeInsets.all(10)),
        ]),
      ],
    );
  }
}
