import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base_file_headers.dart';

class AnimatedSheetView extends StatefulWidget {
  final InformationViewStatus? step;
  final Widget? contentWidget;
  final dynamic config;
  final void Function() didCompleteShowCallback;
  final void Function() didCompleteHideCallback;
  final void Function() backgroundTapCallback;

  const AnimatedSheetView({
    Key? key,
    this.step,
    this.contentWidget,
    this.config,
    required this.didCompleteShowCallback,
    required this.didCompleteHideCallback,
    required this.backgroundTapCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedSheetViewState();
}

class _AnimatedSheetViewState extends State<AnimatedSheetView> with TickerProviderStateMixin {
  /// 背景色动画的key
  static const String containerColorKey = 'containerColor';

  /// 背景色动画的key
  static const String offsetKey = 'offset';

  /// 当前是否是动画中
  bool isAnimating = false;

  /// 动画管理器
  AnimationsManager? _animationsManager;

  Map<String, CurveTweenObject> _getAnimationsObjectByStep(InformationViewStatus step) {
    var config = widget.config as AnimatedSheetViewConfig;
    Map<String, CurveTweenObject> map = {};
    Color color_1 = Colors.transparent;
    Color color_2 = config.backgroundColor ?? Colors.transparent;
    double value_1 = 0, value_2 = 0;
    switch (config.type) {
      case AnimatedSheetType.fromBottomToTop:
        value_1 = Get.height;
        value_2 = 0;
        break;
      case AnimatedSheetType.fromTopToBottom:
        value_1 = -Get.height;
        value_2 = 0;
        break;
      case AnimatedSheetType.fromLeftToRight:
        value_1 = -Get.width;
        value_2 = 0;
        break;
      case AnimatedSheetType.fromRightToLeft:
        value_1 = Get.width;
        value_2 = 0;
        break;
    }

    if (widget.step == InformationViewStatus.idle || widget.step == InformationViewStatus.show) {
      map[containerColorKey] = CurveTweenObject(tween: ColorTween(begin: color_1, end: color_2));
      map[offsetKey] = CurveTweenObject(tween: Tween<double>(begin: value_1, end: value_2), curve: config.showCurve);
    } else if (widget.step == InformationViewStatus.hide) {
      map[containerColorKey] = CurveTweenObject(tween: ColorTween(begin: color_2, end: color_1));
      map[offsetKey] = CurveTweenObject(tween: Tween<double>(begin: value_2, end: value_1), curve: config.hideCurve);
    }

    return map;
  }

  /// 初始化动画相关参数
  void initAnimationsManager() {
    var config = widget.config as AnimatedSheetViewConfig;
    bool? startAnimated;
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
        duration: duration ?? const Duration(milliseconds: 1000),
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
  void didUpdateWidget(covariant AnimatedSheetView oldWidget) {
    super.didUpdateWidget(oldWidget);
    initAnimationsManager();
  }

  @override
  Widget build(BuildContext context) {
    var config = widget.config as AnimatedSheetViewConfig;

    bool isVerticalAnimation;
    if (config.type == AnimatedSheetType.fromTopToBottom || config.type == AnimatedSheetType.fromBottomToTop) {
      isVerticalAnimation = true;
    } else {
      isVerticalAnimation = false;
    }

    return AnimatedBuilder(
      animation: _animationsManager!.controller,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            Positioned(
              child: GestureDetector(
                onTap: widget.backgroundTapCallback,
                child: Container(
                  color: config.backgroundColor == null
                      ? Colors.transparent
                      : _animationsManager!.animationByKey(containerColorKey).value,
                ),
              ),
            ),
            Positioned(
              top: isVerticalAnimation == true ? _animationsManager!.animationByKey(offsetKey).value : 0,
              left: isVerticalAnimation == false ? _animationsManager!.animationByKey(offsetKey).value : 0,
              right: isVerticalAnimation == false ? -_animationsManager!.animationByKey(offsetKey).value : 0,
              bottom: isVerticalAnimation == true ? -_animationsManager!.animationByKey(offsetKey).value : 0,
              child: Container(child: child),
            ),
            Positioned(
              child: IgnorePointer(
                ignoring: isAnimating ? false : true, // 动画期间屏蔽事件响应
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
