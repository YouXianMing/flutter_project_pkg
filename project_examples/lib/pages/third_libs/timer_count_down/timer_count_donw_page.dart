import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/pages/base/normal_stateless_widget.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:timer_count_down/timer_count_down.dart';

class TimerCountDownPage extends NormalStatelessWidget {
  TimerCountDownPage({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
      );

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Countdown(
        seconds: 10,
        build: (context, value) => WidgetsFactory.text(
          value == 0 ? '完成' : value.toInt().toString(),
          color: Util.randomOpaqueColor,
          fontSize: 100,
          fontWeight: FontWeight.w300,
        ),
        onFinished: () => appPrint('onFinished'),
      ),
    );
  }
}
