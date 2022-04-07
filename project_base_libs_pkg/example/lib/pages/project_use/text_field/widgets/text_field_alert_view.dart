import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'alert_field.dart';
import 'alert_view_button.dart';

class TextFieldAlertView {
  static void show(
    BuildContext? context, {
    required String title, // 标题
    required AlertField field, // 内容控件
    double centerOffset = 0, // 离中心点偏离的位置(必须>=0)
    bool blockMaybePopEvent = false, // 是否屏蔽MaybePop事件,默认为false
    bool hostByMaybePopManager = true, // 是否被MaybePopManager接管,默认为true
    bool twoButtonsAtCrossDirection = true, // 如果只有两个按钮,是否横向排列,默认为true
    required List<AlertViewButton> buttons, // 按钮控件
  }) {
    if (context == null) return;
    assert(!(centerOffset < 0));

    // 弹出框初始化
    InformationView informationView = InformationView(
      type: AnimatedWidgetType.popView,
      config: AnimatedPopViewConfig(showScale: 1, hideScale: 1),
      waitForBuild: true,
    );

    var widgets = <Widget>[];

    // 标题
    widgets.add(const SizedBox(height: 20));

    widgets.add(WidgetsFactory.text(title, fontSize: 16, textAlign: TextAlign.center, color: Colors.blueGrey));

    // 控件
    widgets.add(const SizedBox(height: 10));
    widgets.add(field.widget());
    widgets.add(const SizedBox(height: 10));

    // 线条
    widgets.add(_line(height: 1));

    // 底部按钮(只有2个按钮时,有特殊的处理处理方式,横向两个,还是一排一个)
    if (buttons.length == 2 && twoButtonsAtCrossDirection) {
      List<Widget> buttonsList = [];
      buttons.forEachIndexed((element, index) {
        buttonsList.add(
          Expanded(
            flex: 1,
            child: OpacityButtonWidget(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                informationView.hide(complete: (v) {
                  if (element.onTap != null) (element.onTap)!(field.inputText);
                });
              },
              child: element,
            ),
          ),
        );
        if (buttons.length - 1 != index) buttonsList.add(_line(width: 1, height: 45));
      });

      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttonsList,
      ));
    } else {
      List<Widget> buttonsList = [];
      buttons.forEachIndexed((element, index) {
        buttonsList.add(
          OpacityButtonWidget(
            onTap: () {
              informationView.hide(complete: (v) {
                if (element.onTap != null) (element.onTap)!(field.inputText);
              });
            },
            child: element,
          ),
        );
        if (buttons.length - 1 != index) buttonsList.add(_line(height: 1));
      });

      widgets.add(Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: buttonsList));
    }

    informationView.inOverlay(context);

    // 是否屏蔽安卓物理返回键相关设置
    informationView.managerMaybePopEvent(
      hostByMaybePopManager: hostByMaybePopManager,
      blockMaybePopEvent: blockMaybePopEvent,
    );

    informationView.setWidgetBuilder((v) {
      return Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 320,
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(mainAxisSize: MainAxisSize.min, children: widgets),
            ).addTapEvent(() {}),
            SizedBox(height: centerOffset),
          ],
        ),
      ).addDefaultTextStyle();
    }).show(complete: (v) => field.focusNode.requestFocus());
  }

  static Widget _line({double? height, double? width}) => Container(height: height, width: width, color: Colors.grey.withOpacity(0.2));
}
