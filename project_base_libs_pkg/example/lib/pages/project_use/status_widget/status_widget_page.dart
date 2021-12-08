import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateless_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class StatusWidgetPage extends NormalStatelessWidget {
  final PageArguments? arguments;
  StatusWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(arguments?.mark ?? ''),
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

    return AnimatedContainer(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 150),
      color: backgroundColor,
      child: WidgetsFactory.text(v.data.toString(), color: Colors.white, fontSize: 15),
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

    return AnimatedContainer(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 150),
      color: backgroundColor,
      child: WidgetsFactory.text(v.data.toString(), color: Colors.white, fontSize: 15),
    );
  }

  Widget button3Widget(StatusWidget v, StatusWidgetStatus status) {
    late Color backgroundColor;
    late IconData icon;
    late double width;
    switch (status) {
      case StatusWidgetStatus.selected:
        backgroundColor = Colors.blue;
        icon = Icons.sentiment_satisfied_sharp;
        width = 100;
        break;
      case StatusWidgetStatus.unselected:
        backgroundColor = Colors.blue.withOpacity(0.5);
        icon = Icons.sentiment_dissatisfied_outlined;
        width = 95;
        break;
      case StatusWidgetStatus.disable:
        backgroundColor = Colors.grey;
        icon = Icons.sentiment_very_dissatisfied_outlined;
        width = 80;
        break;
      default:
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: width,
      height: width,
      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: backgroundColor),
      child: Icon(icon, color: Colors.white, size: 60),
    );
  }
}
