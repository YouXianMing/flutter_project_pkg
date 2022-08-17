import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project_examples/pages/base/normal_stateless_widget.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class AnimationsManagerRandomPage extends NormalStatelessWidget {
  AnimationsManagerRandomPage({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
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
  late Timer timer;

  static const String bgColor = 'bgColor';
  static const String percent = 'percent';

  late AnimationsManager manager;

  late double beginPercentValue;
  late double endPercentValue;

  late Color beginColor;
  late Color endColor;

  @override
  void initState() {
    super.initState();

    // 设置初始值结束值
    beginPercentValue = 0;
    endPercentValue = Util.randomPercent;
    beginColor = Colors.black;
    endColor = ([...Colors.primaries]..shuffle()).first;

    manager = AnimationsManager(
      tickerProvider: this,
      duration: const Duration(seconds: 1),
      animationObjectMap: {
        bgColor: CurveTweenObject(tween: ColorTween(begin: beginColor, end: endColor), curve: Curves.linear),
        percent: CurveTweenObject(tween: Tween<double>(begin: beginPercentValue, end: endPercentValue), curve: Curves.easeOutQuint),
      },
    );

    startAnimation();

    // 设置定时器
    timer = Timer.periodic(const Duration(milliseconds: 1600), (timer) => startAnimation());
  }

  void startAnimation() {
    // 更新动画对象
    manager.setAnimationObject(key: bgColor, value: CurveTweenObject(tween: ColorTween(begin: beginColor, end: endColor), curve: Curves.linear));

    // 更新动画对象
    manager.setAnimationObject(
        key: percent, value: CurveTweenObject(tween: Tween<double>(begin: beginPercentValue, end: endPercentValue), curve: Curves.easeOutQuint));

    // 更新动画参数
    beginPercentValue = endPercentValue;
    endPercentValue = Random().nextDouble();
    beginColor = endColor;
    endColor = ([...Colors.primaries]..shuffle()).first;

    // 更新动画时间
    manager.duration = Duration(milliseconds: Util.randomInt(min: 100, max: 1500));

    // 开始执行动画
    manager.forward(from: 0);
  }

  @override
  void dispose() {
    timer.cancel();
    manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return manager.animatedBuilder(
      child: null,
      builder: (context, child) {
        return Center(
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            height: 5,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: manager.animationByKey(percent).value,
              heightFactor: 1,
              child: Container(color: manager.animationByKey(bgColor).value),
            ),
          ),
        );
      },
    );
  }
}
