import 'package:flutter/cupertino.dart';
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
  final _enableButton = true.obs;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => ListView(
        children: [
          BgColorButtonWidget(
            disable: _enableButton.value == false,
            highlightedBgColor: Colors.cyan,
            disabledBgColor: Colors.grey.withOpacity(0.2),
            onTap: () => appPrint('BgColorButtonWidget'),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: WidgetsFactory.text('BgColorButtonWidget', textAlign: TextAlign.center),
            ),
          ).addPaddingOnly(left: 10, top: 10, right: 10),
          ScaleButtonWidget(
            disable: _enableButton.value == false,
            highlightedScale: 0.9,
            disabledScale: 0.95,
            onTap: () => appPrint('ScaleButtonWidget'),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              child: WidgetsFactory.text('ScaleButtonWidget', textAlign: TextAlign.center),
            ),
          ).addPaddingOnly(left: 10, top: 10, right: 10),
          OpacityButtonWidget(
            disable: _enableButton.value == false,
            onTap: () => appPrint('OpacityButtonWidget'),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              child: WidgetsFactory.text('OpacityButtonWidget', textAlign: TextAlign.center),
            ),
          ).addPaddingOnly(left: 10, top: 10, right: 10),
          CupertinoSwitch(
            value: _enableButton.value,
            onChanged: (v) => _enableButton.value = v,
          ).addPaddingOnly(left: 10, top: 10, right: 10),
        ],
      ),
    );
  }
}
