import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class CustomButtonsPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const CustomButtonsPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => CustomButtonsPageState();
}

class CustomButtonsPageState extends NormalStatefulWidgetState<CustomButtonsPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return ListView(
      children: [
        BgColorButtonWidget(
          highlightedBgColor: Colors.red,
          disabledBgColor: Colors.grey.withOpacity(0.5),
          onTap: () => appPrint('BgColorButtonWidget'),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: WidgetsFactory.text('BgColorButtonWidget', textAlign: TextAlign.center),
          ),
        ),
        ScaleButtonWidget(
          highlightedScale: 0.9,
          onTap: () => appPrint('ScaleButtonWidget'),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            child: WidgetsFactory.text('ScaleButtonWidget', textAlign: TextAlign.center),
          ),
        ),
        OpacityButtonWidget(
          onTap: () => appPrint('OpacityButtonWidget'),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            child: WidgetsFactory.text('OpacityButtonWidget', textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}
