import 'package:project_base_libs_pkg/base/tools/app_print.dart';
import 'package:project_examples/file_headers.dart';
import 'package:project_examples/pages/third_libs/flutter_picker/widgets/date_picker_widget.dart';

class FlutterPickerPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const FlutterPickerPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => FlutterPickerPageState();
}

class FlutterPickerPageState extends NormalStatefulWidgetState<FlutterPickerPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return DatePickerWidget(
      locale: AppInt.language.value == AppLanguage.chinese.code ? DatePickerLocale.chinese : DatePickerLocale.english,
      onSelect: (DateTime? dateTime) {
        appPrint(dateTime);
      },
    );
  }
}
