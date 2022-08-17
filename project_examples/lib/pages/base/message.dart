import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class Message {
  void show(
    BuildContext context,
    String text, {
    bool success = true,
    Duration duration = const Duration(seconds: 2),
  }) {
    InformationView(
      type: AnimatedWidgetType.simpleToast,
      waitForBuild: true,
      // debugPrintInfo: true,
      data: text,
    ).inOverlay(context).setWidgetBuilder((v) => _informationViewContentWidget(v.data as String, success)).show().hide(afterDelay: duration);
  }

  Widget _informationViewContentWidget(String text, bool success) {
    return Container(
      color: Colors.black.withAlpha(75),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          color: success ? Colors.red : Colors.yellow,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Get.width * 0.50),
            child: Text(
              text,
              style: TextStyle(color: success ? Colors.white : Colors.black, fontSize: 18),
              textAlign: TextAlign.center,
            ).addDefaultTextStyle(),
          ),
        ),
      ),
    );
  }
}
