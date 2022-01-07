import 'package:flutter/material.dart';
import '../../../base_file_headers.dart';

class AnimatedPopView extends StatefulWidget {
  final InformationViewStatus? step;
  final Widget? contentWidget;
  final dynamic config;
  final void Function() didCompleteShowCallback;
  final void Function() didCompleteHideCallback;
  final void Function() backgroundTapCallback;

  const AnimatedPopView({
    Key? key,
    this.step,
    this.contentWidget,
    this.config,
    required this.didCompleteShowCallback,
    required this.didCompleteHideCallback,
    required this.backgroundTapCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedPopViewState();
}

class _AnimatedPopViewState extends State<AnimatedPopView> with TickerProviderStateMixin {
  /// 缩放动画的key
  static const String scaleKey = 'scale';

  /// 透明度动画的key
  static const String alphaKey = 'alpha';

  /// 背景色动画的key
  static const String containerColorKey = 'containerColor';

  /// 当前是否是动画中
  bool isAnimating = false;

  /// 动画管理器
  AnimationsManager? _animationsManager;

  Map<String, CurveTweenObject> _getAnimationsObjectByStep(InformationViewStatus step) {
    Map<String, CurveTweenObject> map = {};
    var config = widget.config as AnimatedPopViewConfig;
    Color color_1 = Colors.transparent;
    Color color_2 = config.backgroundColor ?? Colors.black.withOpacity(0.2);

    if (widget.step == InformationViewStatus.idle || widget.step == InformationViewStatus.show) {
      map[scaleKey] =
          CurveTweenObject(tween: Tween<double>(begin: config.showScale, end: 1.0), curve: config.showCurve);
      map[alphaKey] = CurveTweenObject(tween: Tween<double>(begin: 0.0, end: 1.0));
      map[containerColorKey] = CurveTweenObject(tween: ColorTween(begin: color_1, end: color_2));
    } else if (widget.step == InformationViewStatus.hide) {
      map[scaleKey] =
          CurveTweenObject(tween: Tween<double>(begin: 1.0, end: config.hideScale), curve: config.hideCurve);
      map[alphaKey] = CurveTweenObject(tween: Tween<double>(begin: 1.0, end: 0.0));
      map[containerColorKey] = CurveTweenObject(tween: ColorTween(begin: color_2, end: color_1));
    }

    return map;
  }

  /// 初始化动画相关参数
  void initAnimationsManager() {
    var config = widget.config as AnimatedPopViewConfig;
    bool startAnimated = false;
    Duration? duration;
    if (widget.step == InformationViewStatus.idle) {
      startAnimated = false;
      duration = Duration.zero;
    } else if (widget.step == InformationViewStatus.show) {
      startAnimated = true;
      duration = config.showDuration;
    } else if (widget.step == InformationViewStatus.hide) {
      startAnimated = true;
      duration = config.hideDuration;
    }

    _animationsManager = AnimationsManager(
        tickerProvider: this,
        duration: duration ?? const Duration(milliseconds: 250),
        animationObjectMap: _getAnimationsObjectByStep(widget.step!),
        completedCallback: () {
          isAnimating = false;
          setState(() {});
          if (widget.step == InformationViewStatus.show) {
            widget.didCompleteShowCallback();
          } else if (widget.step == InformationViewStatus.hide) {
            widget.didCompleteHideCallback();
          }
        });

    if (startAnimated == true) {
      isAnimating = true;
      _animationsManager!.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    initAnimationsManager();
  }

  @override
  void didUpdateWidget(covariant AnimatedPopView oldWidget) {
    super.didUpdateWidget(oldWidget);
    initAnimationsManager();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationsManager!.controller,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            Positioned(
              child: GestureDetector(
                onTap: widget.backgroundTapCallback,
                child: Container(
                  color: _animationsManager!.animationByKey(containerColorKey).value,
                  child: Transform.scale(
                    scale: _animationsManager!.animationByKey(scaleKey).value,
                    child: Opacity(opacity: _animationsManager!.animationByKey(alphaKey).value, child: child),
                  ),
                ),
              ),
            ),
            Positioned(
              child: IgnorePointer(
                ignoring: isAnimating ? false : true,

                /// 动画期间屏蔽事件响应
                child: Container(color: Colors.transparent),
              ),
            ),
          ],
        );
      },
      child: Center(child: widget.contentWidget),
    );
  }
}
