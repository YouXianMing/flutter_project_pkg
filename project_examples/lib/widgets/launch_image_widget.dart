import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

enum LaunchImageWidgetStatus {
  idle,
  start,
  didHide,
}

class LaunchImageWidget extends StatefulWidget {
  const LaunchImageWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LaunchImageWidgetState();
}

class LaunchImageWidgetState extends State<LaunchImageWidget> {
  final status = LaunchImageWidgetStatus.idle.obs;

  @override
  void initState() {
    super.initState();
    Util.delayedMilliseconds(1500, () => status.value = LaunchImageWidgetStatus.start);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (status.value) {
        case LaunchImageWidgetStatus.idle:
          return AnimatedOpacity(opacity: 1, duration: Duration.zero, child: _widgetItem());

        case LaunchImageWidgetStatus.start:
          return AnimatedOpacity(
            opacity: 0,
            duration: const Duration(milliseconds: 550),
            child: _widgetItem(),
            onEnd: () => status.value = LaunchImageWidgetStatus.didHide,
          );

        case LaunchImageWidgetStatus.didHide:
          return const SizedBox();
      }
    });
  }

  Widget _widgetItem() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: Colors.white,
      child: Stack(
        children: [
          MarqueeScrollWidget(
            scrollDirection: Axis.vertical,
            child: AspectRatio(
              aspectRatio: 752 / 3000,
              child: Util.image('login_longpic_background.webp').addOpacity(0.25),
            ),
          ),
          Center(child: WidgetsFactory.text('YouXianMing', fontSize: 20.sp, color: Colors.blueAccent)),
        ],
      ),
    ).addDefaultTextStyle();
  }
}
