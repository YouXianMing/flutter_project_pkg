import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/tools/auto_obx.dart';

enum LotteryCarouselStatus {
  /// 默认状态(不转)
  idle,

  /// 开始转动(从不转到开始转动阶段的动画)
  startRotating,

  /// 持续转动(匀速转动阶段的动画)
  keepRotating,

  /// 结束转动(从匀速转动到结束转动阶段的动画)
  endRotating,
}

class LotteryCarouselConfig {
  /// 一轮动画需要转动的圈数
  final double turnsPerRound;

  /// 匀速转动时的圈数补偿
  final double turnsCompensation;

  /// 一轮动画的时间
  final Duration roundDuration;

  /// 构造器
  const LotteryCarouselConfig({required this.turnsPerRound, required this.turnsCompensation, required this.roundDuration});

  /// .normal命名构造器
  const LotteryCarouselConfig.normal()
      : turnsPerRound = 3,
        turnsCompensation = 0.7,
        roundDuration = const Duration(milliseconds: 1200);
}

class LotteryCarouselManager {
  /// 当前状态
  LotteryCarouselStatus _currentStatus = LotteryCarouselStatus.idle;

  /// 自动更新用组件
  final _autoObxWidget = AutoObx();

  /// 累计转动圈数
  double _turns = 0.0;

  /// 结束在百分之几
  double _endAtPercent = 0.0;

  /// 标记结束动画
  bool _markToEnd = false;

  /// 是否处于旋转当中
  bool _isInRotating = false;

  /// 轮盘停止时的回调
  Function()? _didEndRotateCallback;

  /// 持续执行转动动画
  void _keepRotating() {
    _turns += config.turnsPerRound + config.turnsCompensation;
    _currentStatus = LotteryCarouselStatus.keepRotating;
    _autoObxWidget.manualUpdate();
  }

  final LotteryCarouselConfig config;

  /// 重置
  void reset() {
    _turns = 0;
    _currentStatus = LotteryCarouselStatus.idle;
    _markToEnd = false;
    _autoObxWidget.manualUpdate();
  }

  /// 开始执行转动动画
  void startRotating() {
    if (_isInRotating == false) {
      _turns += config.turnsPerRound;
      _currentStatus = LotteryCarouselStatus.startRotating;
      _autoObxWidget.manualUpdate();
    }
  }

  /// 准备结束转动动画
  void endRotatingAtPercent(double percent, {Function()? didEndRotateCallback}) {
    if (_markToEnd == false &&
        (_currentStatus == LotteryCarouselStatus.startRotating || _currentStatus == LotteryCarouselStatus.keepRotating)) {
      _markToEnd = true;
      _endAtPercent = percent;
      _currentStatus = LotteryCarouselStatus.endRotating;
      _didEndRotateCallback = didEndRotateCallback;
    }
  }

  LotteryCarouselManager({this.config = const LotteryCarouselConfig.normal()});
}

class LotteryCarouselWidget extends StatefulWidget {
  /// 旋转动画的管理器
  final LotteryCarouselManager manager;

  /// 被旋转的child
  final Widget rotateChild;

  /// 开启debug信息
  final bool? enableDebugInfo;

  const LotteryCarouselWidget({
    Key? key,
    required this.manager,
    required this.rotateChild,
    this.enableDebugInfo,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LotteryCarouselWidgetState();
}

class LotteryCarouselWidgetState extends State<LotteryCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.manager._autoObxWidget.buildObx(() {
      late Curve curve;
      late Duration duration;
      switch (widget.manager._currentStatus) {
        case LotteryCarouselStatus.idle:
          curve = Curves.linear;
          duration = Duration.zero;
          widget.manager._isInRotating = false;
          break;
        case LotteryCarouselStatus.startRotating:
          curve = Curves.easeIn;
          duration = widget.manager.config.roundDuration;
          widget.manager._isInRotating = true;
          break;
        case LotteryCarouselStatus.keepRotating:
          curve = Curves.linear;
          duration = widget.manager.config.roundDuration;
          widget.manager._isInRotating = true;
          break;
        case LotteryCarouselStatus.endRotating:
          curve = Curves.easeOut;
          duration = widget.manager.config.roundDuration;
          widget.manager._isInRotating = true;
          break;
      }

      return AnimatedRotation(
        turns: widget.manager._turns,
        duration: duration,
        curve: curve,
        onEnd: () {
          // 如果标记为结束状态,则在上一轮动画结束后开始执行下一轮的结束动画
          if (widget.manager._markToEnd == true) {
            // 距离一整个圆的差值
            var remainTurn = 1 - (widget.manager._turns - widget.manager._turns.truncate());

            // 结束动画时的需要转动的圈数
            var fullTurns = (remainTurn + (widget.manager.config.turnsPerRound - 1)) + widget.manager._endAtPercent;
            if (fullTurns >= widget.manager.config.turnsPerRound) fullTurns -= 1;

            if (widget.enableDebugInfo == true) {
              // ignore: avoid_print
              print('''
              
              累计圈数:${widget.manager._turns.toStringAsFixed(3)}
              计算差值:${remainTurn.toStringAsFixed(3)}
              结束动画时的需要转动的圈数:${fullTurns.toStringAsFixed(3)}
              设定结束时的百分比:${widget.manager._endAtPercent.toStringAsFixed(3)}
              最终累计圈数:${(widget.manager._turns + fullTurns).toStringAsFixed(3)}
              
              ''');
            }

            widget.manager._turns += fullTurns;
            widget.manager._currentStatus = LotteryCarouselStatus.endRotating;
            widget.manager._autoObxWidget.manualUpdate();
            widget.manager._markToEnd = false;
            return;
          }

          if (widget.manager._currentStatus == LotteryCarouselStatus.endRotating) {
            // 结束的回调
            if (widget.manager._didEndRotateCallback != null) widget.manager._didEndRotateCallback!();
          }

          if (widget.manager._currentStatus == LotteryCarouselStatus.startRotating ||
              widget.manager._currentStatus == LotteryCarouselStatus.keepRotating) {
            widget.manager._keepRotating();
          }

          widget.manager._isInRotating = false;
        },
        child: widget.rotateChild,
      );
    });
  }
}
