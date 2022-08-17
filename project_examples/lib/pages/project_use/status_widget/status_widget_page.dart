import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/pages/base/normal_stateless_widget.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusWidgetPage extends NormalStatelessWidget {
  StatusWidgetPage({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
      );

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatusWidget.normalButton(
          initData: 1,
          normalStatusBuilder: (v) => button1Widget(v, StatusWidgetStatus.normal),
          highlightedStatusBuilder: (v) => button1Widget(v, StatusWidgetStatus.highlighted),
          disableStatusBuilder: (v) => button1Widget(v, StatusWidgetStatus.disable),
          onTap: (v) {
            v.setData(v.data + 1);
            if (v.data > 5) {
              v.setDisable(true);
            }
            v.update();
          },
        ),
        StatusWidget.normalButton(
          initData: 1,
          normalStatusBuilder: (v) => button2Widget(v, StatusWidgetStatus.normal),
          highlightedStatusBuilder: (v) => button2Widget(v, StatusWidgetStatus.highlighted),
          disableStatusBuilder: (v) => button2Widget(v, StatusWidgetStatus.disable),
          onTap: (v) {
            v.setData(v.data + 1);
            if (v.data > 5) {
              v.setDisable(true);
            }
            v.update();
          },
        ),
        StatusWidget.selectedButton(
          initSelectValue: true,
          enableAutoSelect: true,
          selectedStatusBuilder: (v) => button3Widget(v, StatusWidgetStatus.selected),
          unselectedStatusBuilder: (v) => button3Widget(v, StatusWidgetStatus.unselected),
          disableStatusBuilder: (v) => button3Widget(v, StatusWidgetStatus.disable),
          onTap: (v) {
            if (Util.randomPercent > 0.8) {
              v.setDisable(true);
              v.update();
            }
          },
        ),
      ],
    );
  }

  Widget button1Widget(StatusWidget v, StatusWidgetStatus status) {
    late Color backgroundColor;
    switch (status) {
      case StatusWidgetStatus.normal:
        backgroundColor = Colors.blue;
        break;
      case StatusWidgetStatus.highlighted:
        backgroundColor = Colors.blue.withOpacity(0.5);
        break;
      case StatusWidgetStatus.disable:
        backgroundColor = Colors.grey;
        break;
      default:
        break;
    }

    return WidgetsFactory.textContainer(
      v.data.toString(),
      padding: const EdgeInsets.all(15),
      textColor: Colors.white,
      backgroundColor: backgroundColor,
      fontSize: 30.sp,
      alignment: Alignment.center,
    );
  }

  Widget button2Widget(StatusWidget v, StatusWidgetStatus status) {
    late Color backgroundColor;
    switch (status) {
      case StatusWidgetStatus.normal:
        backgroundColor = Colors.blue;
        break;
      case StatusWidgetStatus.highlighted:
        backgroundColor = Colors.blue.withOpacity(0.5);
        break;
      case StatusWidgetStatus.disable:
        backgroundColor = Colors.grey;
        break;
      default:
        break;
    }

    return WidgetsFactory.textContainer(
      v.data.toString(),
      padding: const EdgeInsets.all(15),
      textColor: Colors.white,
      backgroundColor: backgroundColor,
      fontSize: 30.sp,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      alignment: Alignment.center,
    );
  }

  Widget button3Widget(StatusWidget v, StatusWidgetStatus status) {
    late Color backgroundColor;
    late IconData icon;
    switch (status) {
      case StatusWidgetStatus.selected:
        backgroundColor = Colors.blue;
        icon = Icons.sentiment_satisfied_sharp;
        break;
      case StatusWidgetStatus.unselected:
        backgroundColor = Colors.blue.withOpacity(0.5);
        icon = Icons.sentiment_dissatisfied_outlined;
        break;
      case StatusWidgetStatus.disable:
        backgroundColor = Colors.grey;
        icon = Icons.sentiment_very_dissatisfied_outlined;
        break;
      default:
        break;
    }

    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: backgroundColor,
      ),
      child: Icon(icon, color: Colors.white, size: 60),
    );
  }
}
