import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class SpValPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const SpValPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => SpValPageState();
}

class SpValPageState extends NormalStatefulWidgetState<SpValPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    // 用枚举值来存储参数
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
