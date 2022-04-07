import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/pages/project_use/text_field/widgets/alert_field.dart';
import 'package:example/pages/project_use/text_field/widgets/alert_view_button.dart';
import 'package:example/pages/project_use/text_field/widgets/text_field_alert_view.dart';
import 'package:example/widgets/app_button.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class TextFieldPage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const TextFieldPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _TextFieldPageState();
}

class _TextFieldPageState extends NormalStatefulWidgetState<TextFieldPage> {
  final inputText = ''.obs;

  final controller = TextEditingController();

  @override
  PreferredSizeWidget? appBar(BuildContext context) =>
      NormalAppBar(context: context, title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''));

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        // Field
        CustomTextField(
          editingController: controller,
          placeHolder: 'Input your text.',
          padding: const EdgeInsets.symmetric(horizontal: 10),
          textStyle: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          placeHolderTextStyle: TextStyle(color: Colors.grey.withOpacity(0.7), fontWeight: FontWeight.normal),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.7)),
          ),
          prefixWidget: const Icon(Icons.verified_user, color: Colors.grey).addPaddingOnly(right: 10),
          suffixWidget: Obx(() => AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: inputText.value.isEmpty ? 0 : 1,
                child: OpacityButtonWidget(
                  color: Colors.transparent,
                  onTap: () {
                    inputText.value = '';
                    controller.clear();
                  },
                  child: const Icon(Icons.clear_rounded, color: Colors.black45),
                ),
              )),
          onChanged: (text) => inputText.value = text,
        ).addPaddingOnly(left: 10, right: 10, top: 10),

        // 按钮
        Obx(() => AppButton(
              disable: inputText.value.isEmpty,
              height: 45,
              borderRadius: 10,
              onTap: () {
                showMessage(context, inputText.value);
                hideKeyBoard(context);
              },
              style: AppButtonStyle.blue,
              child: WidgetsFactory.text('Confirm', color: Colors.white, fontSize: 18),
            ).addPaddingOnly(left: 10, right: 10, top: 10)),

        AppButton(
          height: 45,
          borderRadius: 10,
          onTap: () {
            TextFieldAlertView.show(
              context,
              title: 'Alert TextField',
              field: AlertField(placeHolder: 'placeHolder', limitLength: 20, text: ''),
              centerOffset: 180,
              buttons: [
                AlertViewButton.blue('取消'),
                AlertViewButton.boldRed('确定', onTap: (text) {
                  appPrint(text);
                }),
              ],
            );
          },
          style: AppButtonStyle.blue,
          child: WidgetsFactory.text('Alert Field', color: Colors.white, fontSize: 18),
        ).addPaddingOnly(left: 10, right: 10, top: 10),
      ],
    ).addTapEvent(() => hideKeyBoard(context), includeContainer: true);
  }
}
