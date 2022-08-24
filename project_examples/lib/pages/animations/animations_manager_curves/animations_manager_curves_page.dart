import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class AnimationsManagerCurvesPage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const AnimationsManagerCurvesPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AnimationsManagerCurvesPageState();
}

class AnimationsManagerCurvesPageState extends NormalStatefulWidgetState<AnimationsManagerCurvesPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) => const AnimationsManagerUseDemo();
}

class AnimationsManagerUseDemo extends StatefulWidget {
  const AnimationsManagerUseDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimationsManagerUseDemoState();
}

class _AnimationsManagerUseDemoState extends State<AnimationsManagerUseDemo> with SingleTickerProviderStateMixin {
  static const String percent = 'percent';

  late AnimationsManager manager;
  late Curve currentCurve;
  RxString currentCurveKey = ''.obs;

  late Map<String, dynamic> curvesMap;
  late List<String> sortKeys;

  @override
  void initState() {
    super.initState();

    // 自定义的curve的参数
    // https://cubic-bezier.com/

    curvesMap = {
      '[特殊] linear': Curves.linear,
      '[特殊] decelerate': Curves.decelerate,
      '[特殊] bounceIn': Curves.bounceIn,
      '[特殊] bounceOut': Curves.bounceOut,
      '[特殊] bounceInOut': Curves.bounceInOut,
      '[特殊] elasticIn': Curves.elasticIn,
      '[特殊] elasticOut': Curves.elasticOut,
      '[特殊] elasticInOut': Curves.elasticInOut,
      'fastLinearToSlowEaseIn': Curves.fastLinearToSlowEaseIn,
      '[自定义] Cubic(0.11, 0.87, 0.44, 1)': const Cubic(0.11, 0.87, 0.44, 1),
      '[自定义] Cubic(0.07, 0.56, 0.88, 43)': const Cubic(0.07, 0.56, 0.88, 0.43),
      'ease': Curves.ease,
      'easeIn': Curves.easeIn,
      'easeInToLinear': Curves.easeInToLinear,
      'easeInSine': Curves.easeInSine,
      'easeInQuad': Curves.easeInQuad,
      'easeInCubic': Curves.easeInCubic,
      'easeInQuart': Curves.easeInQuart,
      'easeInQuint': Curves.easeInQuint,
      'easeInExpo': Curves.easeInExpo,
      'easeInCirc': Curves.easeInCirc,
      'easeInBack': Curves.easeInBack,
      'easeOut': Curves.easeOut,
      'linearToEaseOut': Curves.linearToEaseOut,
      'easeOutSine': Curves.easeOutSine,
      'easeOutQuad': Curves.easeOutQuad,
      'easeOutCubic': Curves.easeOutCubic,
      'easeOutQuart': Curves.easeOutQuart,
      'easeOutQuint': Curves.easeOutQuint,
      'easeOutExpo': Curves.easeOutExpo,
      'easeOutCirc': Curves.easeOutCirc,
      'easeOutBack': Curves.easeOutBack,
      'easeInOut': Curves.easeInOut,
      'easeInOutSine': Curves.easeInOutSine,
      'easeInOutQuad': Curves.easeInOutQuad,
      'easeInOutCubic': Curves.easeInOutCubic,
      'easeInOutQuart': Curves.easeInOutQuart,
      'easeInOutQuint': Curves.easeInOutQuint,
      'easeInOutExpo': Curves.easeInOutExpo,
      'easeInOutCirc': Curves.easeInOutCirc,
      'easeInOutBack': Curves.easeInOutBack,
      'fastOutSlowIn': Curves.fastOutSlowIn,
      'slowMiddle': Curves.slowMiddle,
    };

    sortKeys = curvesMap.keys.toList();
    sortKeys.sort();

    currentCurve = curvesMap[sortKeys.first];
    currentCurveKey.value = sortKeys.first;
    manager = AnimationsManager(
      tickerProvider: this,
      duration: const Duration(milliseconds: 800),
      animationObjectMap: {percent: CurveTweenObject(tween: Tween<double>(begin: 0.25, end: 0.75), curve: currentCurve)},
    );
  }

  @override
  void dispose() {
    manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomScrollView(
                    slivers: [
                      SliverListSection.builderTypeWidget(
                          items: sortKeys,
                          builder: (c, i, d) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              color: i % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.1),
                              child: WidgetsFactory.text(d.toString()),
                            ).addTapEvent(() {
                              currentCurveKey.value = d;
                              manager.setAnimationObject(
                                  key: percent, value: CurveTweenObject(tween: Tween<double>(begin: 0.25, end: 0.75), curve: curvesMap[d]));
                              manager.forward(from: 0);
                            });
                          }),
                    ],
                  ),
                ),
                Container(height: 1, color: Colors.grey.withOpacity(0.5)),
                Expanded(
                  flex: 1,
                  child: manager.animatedBuilder(
                    child: null,
                    builder: (context, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: CustomPaint(painter: DrawPainter(percent: manager.animationByKey(percent).value)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Obx(() => WidgetsFactory.text(currentCurveKey.value)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(child: TextButton(onPressed: () => manager.forward(from: 0), child: const Icon(Icons.play_arrow))),
              SizedBox(child: TextButton(onPressed: () => manager.animateTo(0, duration: Duration.zero), child: const Icon(Icons.stop))),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawPainter extends CustomPainter {
  final double percent;

  DrawPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5;

    canvas.drawCircle(Offset(size.width / 2 * 1.5, size.height / 2), 80 * percent, paint);
    canvas.drawArc(Rect.fromLTWH(size.width / 2 * 0.5 - 60, size.height / 2 - 60, 120, 120), 0, pi * 2 * percent, true, paint);
    double offsetY = size.height * 0.9;
    Offset start = Offset(0, offsetY);
    Offset end = Offset(size.width * percent, offsetY);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
