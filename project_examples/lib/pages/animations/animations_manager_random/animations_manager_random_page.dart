import 'dart:async';
import 'dart:math';

import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class AnimationsManagerRandomPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const AnimationsManagerRandomPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AnimationsManagerRandomPageState();
}

class AnimationsManagerRandomPageState extends NormalStatefulWidgetState<AnimationsManagerRandomPage> {
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
  late Timer _timer;

  static const String _bgColor = 'bgColor';
  static const String _percent = 'percent';

  late AnimationsManager _manager;

  late double _beginPercentValue;
  late double _endPercentValue;

  late Color _beginColor;
  late Color _endColor;

  @override
  void initState() {
    super.initState();

    // 设置初始值结束值
    _beginPercentValue = 0;
    _endPercentValue = Util.randomPercent;
    _beginColor = Colors.black;
    _endColor = ([...Colors.primaries]..shuffle()).first;

    _manager = AnimationsManager(
      tickerProvider: this,
      duration: const Duration(seconds: 1),
      animationObjectMap: {
        _bgColor: CurveTweenObject(tween: ColorTween(begin: _beginColor, end: _endColor), curve: Curves.linear),
        _percent: CurveTweenObject(tween: Tween<double>(begin: _beginPercentValue, end: _endPercentValue), curve: Curves.easeOutQuint),
      },
    );

    startAnimation();

    // 设置定时器
    _timer = Timer.periodic(const Duration(milliseconds: 1600), (timer) => startAnimation());
  }

  void startAnimation() {
    // 更新动画对象
    _manager.setAnimationObject(
        key: _bgColor, value: CurveTweenObject(tween: ColorTween(begin: _beginColor, end: _endColor), curve: Curves.linear));

    // 更新动画对象
    _manager.setAnimationObject(
        key: _percent,
        value: CurveTweenObject(tween: Tween<double>(begin: _beginPercentValue, end: _endPercentValue), curve: Curves.easeOutQuint));

    // 更新动画参数
    _beginPercentValue = _endPercentValue;
    _endPercentValue = Random().nextDouble();
    _beginColor = _endColor;
    _endColor = ([...Colors.primaries]..shuffle()).first;

    // 更新动画时间
    _manager.duration = Duration(milliseconds: Util.randomInt(min: 100, max: 1500));

    // 开始执行动画
    _manager.forward(from: 0);
  }

  @override
  void dispose() {
    _timer.cancel();
    _manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _manager.animatedBuilder(
      child: null,
      builder: (context, child) {
        return Center(
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            height: 5,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: _manager.animationByKey(_percent).value,
              heightFactor: 1,
              child: Container(color: _manager.animationByKey(_bgColor).value),
            ),
          ),
        );
      },
    );
  }
}
