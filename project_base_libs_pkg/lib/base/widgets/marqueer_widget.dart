import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// https://pub.dev/packages/marqueer (https://github.com/GeceGibi/marqueer)
// 在上述开源库代码基础上进行了部分改动,支持垂直方向的移动

enum MarqueerMoveDirection {
  /// scrollDirection = Axis.horizontal 从右往左移动
  /// scrollDirection = Axis.vertical   从下往上移动
  rtl,

  /// scrollDirection = Axis.horizontal 从左往右移动
  /// scrollDirection = Axis.vertical   从上往下移动
  ltr,
}

class MarqueerWidget extends StatefulWidget {
  MarqueerWidget({
    Key? key,
    required Widget child,
    Widget Function(BuildContext context, int index)? separatorBuilder,
    this.pps = 15.0,
    this.infinity = true,
    this.autoStart = true,
    this.moveDirection = MarqueerMoveDirection.rtl,
    this.scrollDirection = Axis.horizontal,
    this.interaction = true,
    this.restartAfterInteractionDuration = const Duration(seconds: 3),
    this.restartAfterInteraction = true,
    this.onChangeItemInViewPort,
    this.autoStartAfter = Duration.zero,
    this.onInteraction,
    this.controller,
    this.onStarted,
    this.onStopped,
    this.padding = EdgeInsets.zero,
  })  : assert((() {
          if (autoStartAfter > Duration.zero) {
            return autoStart;
          }

          return true;
        })(), 'if `autoStartAfter` duration bigger than `zero` then `autoStart` must be `true`'),
        delegate = SliverChildBuilderDelegate(
          (context, index) {
            onChangeItemInViewPort?.call(index);

            if (separatorBuilder != null) {
              final children = [child];

              if (moveDirection == MarqueerMoveDirection.rtl) {
                children.add(separatorBuilder(context, index));
              } else {
                children.insert(0, separatorBuilder(context, index));
              }

              return Flex(
                direction: scrollDirection,
                children: children,
              );
            }

            return child;
          },
          childCount: infinity ? null : 1,
          addAutomaticKeepAlives: !infinity,
        ),
        super(key: key);

  MarqueerWidget.builder({
    Key? key,
    required Widget Function(BuildContext context, int index) itemBuilder,
    Widget Function(BuildContext context, int index)? separatorBuilder,
    int? itemCount,
    this.pps = 15.0,
    this.autoStart = true,
    this.moveDirection = MarqueerMoveDirection.rtl,
    this.scrollDirection = Axis.horizontal,
    this.interaction = true,
    this.restartAfterInteractionDuration = const Duration(seconds: 3),
    this.restartAfterInteraction = true,
    this.onChangeItemInViewPort,
    this.autoStartAfter = Duration.zero,
    this.onInteraction,
    this.controller,
    this.onStarted,
    this.onStopped,
    this.padding = EdgeInsets.zero,
  })  : assert((() {
          if (autoStartAfter > Duration.zero) {
            return autoStart;
          }

          return true;
        })(), 'if `autoStartAfter` duration bigger than `zero` then `autoStart` must be `true`'),
        infinity = itemCount == null,
        delegate = SliverChildBuilderDelegate(
          (context, index) {
            onChangeItemInViewPort?.call(index);

            final widget = itemBuilder(context, index);

            if (separatorBuilder != null && index + 1 != itemCount) {
              final children = [widget];

              if (moveDirection == MarqueerMoveDirection.rtl) {
                children.add(separatorBuilder(context, index));
              } else {
                children.insert(0, separatorBuilder(context, index));
              }

              return Flex(
                direction: scrollDirection,
                children: children,
              );
            }

            return widget;
          },
          childCount: itemCount,
          addAutomaticKeepAlives: itemCount != null,
        ),
        super(key: key);

  final SliverChildDelegate delegate;

  /// Moved direction
  final MarqueerMoveDirection moveDirection;

  /// Direction
  final Axis scrollDirection;

  /// List View Padding
  final EdgeInsets padding;

  /// Pixel Per Second
  final double pps;

  /// Interactions
  final bool interaction;

  /// Stop when interaction
  final bool restartAfterInteraction;

  /// Restart delay
  final Duration restartAfterInteractionDuration;

  /// Controller
  final MarqueerWidgetController? controller;

  /// auto start
  final bool autoStart;

  /// Auto Start after duration
  final Duration autoStartAfter;

  ///
  final bool infinity;

  /// callbacks
  final void Function()? onStarted;
  final void Function()? onStopped;
  final void Function()? onInteraction;
  final void Function(int index)? onChangeItemInViewPort;

  @override
  State<MarqueerWidget> createState() => _MarqueerWidgetState();
}

class _MarqueerWidgetState extends State<MarqueerWidget> {
  final controller = ScrollController();

  var step = 0.0;
  var offset = 0.0;
  var animating = false;
  var interactionDirection = ScrollDirection.idle;

  late var interaction = widget.interaction;

  Timer? timerLoop;
  Timer? timerInteraction;

  /// default delay added for wait scroll anim. end;
  Duration get duration => Duration(
        milliseconds: ((step / widget.pps) * 1000).round(),
      );

  void animate() {
    controller.animateTo(
      offset + step,
      duration: duration,
      curve: Curves.linear,
    );
  }

  void start() {
    if (animating || !mounted) {
      return;
    }

    if (calculateDistance()) {
      animating = true;
      animate();
      createLoop();
      widget.onStarted?.call();
    }
  }

  /// Duration calculating after every interaction
  /// so Timer.periodic is not a good solution
  void createLoop() {
    final delay = Duration(milliseconds: widget.infinity ? 0 : 50);

    timerLoop?.cancel();
    timerLoop = Timer(duration + delay, () {
      if (calculateDistance()) {
        createLoop();
        animate();
      }
    });
  }

  void stop() {
    if (!animating || !mounted) {
      return;
    }

    animating = false;

    timerLoop?.cancel();
    timerInteraction?.cancel();

    controller.jumpTo(controller.offset);
    offset = controller.offset;

    widget.onStopped?.call();
  }

  bool calculateDistance() {
    final currentPos = controller.offset;
    final maxPos = controller.position.maxScrollExtent;

    if (widget.infinity) {
      offset = currentPos;
      step = 10000.0;
      return true;
    }

    final random = Random();

    // Has scrollable content
    if (maxPos > 0 && maxPos.isFinite) {
      switch (interactionDirection) {
        case ScrollDirection.idle:

          /// just pick random direction and move on
          interactionDirection = random.nextBool() ? ScrollDirection.forward : ScrollDirection.reverse;
          return calculateDistance();

        case ScrollDirection.forward:
          final isStart = currentPos == 0;
          step = isStart ? maxPos : maxPos - (maxPos - currentPos);
          offset = isStart ? 0 : -step;
          break;

        case ScrollDirection.reverse:
          final isEnd = maxPos == currentPos;
          step = isEnd ? maxPos : maxPos - currentPos;
          offset = isEnd ? -maxPos : maxPos - step;
          break;
      }

      return step.isFinite;
    }

    return false;
  }

  void interactionEnabled(bool enabled) {
    if (interaction != enabled) {
      offset = controller.offset;
      timerInteraction?.cancel();

      setState(() {
        interaction = enabled;
      });
    }
  }

  void onPointerUpHandler(PointerUpEvent event) {
    if (widget.restartAfterInteraction) {
      /// Wait for scroll animation end
      timerInteraction = Timer(widget.restartAfterInteractionDuration, () {
        if (calculateDistance()) {
          start();
        }
      });
    }
  }

  void onPointerDownHandler(PointerDownEvent event) {
    animating = false;
    widget.onInteraction?.call();

    /// Clear prev timer if defined
    timerInteraction?.cancel();
    timerLoop?.cancel();
  }

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.autoStart) {
        Future.delayed(widget.autoStartAfter, start);
      }

      if (!widget.infinity) {
        controller.addListener(() {
          final direction = controller.position.userScrollDirection;

          if (interactionDirection != direction) {
            interactionDirection = direction;
          }
        });
      }
    });
  }

  bool get isWebOrDesktop => kIsWeb || (!Platform.isAndroid && !Platform.isIOS);

  bool get isReverse => widget.moveDirection == MarqueerMoveDirection.ltr;

  @override
  void dispose() {
    controller.dispose();
    timerLoop?.cancel();
    timerInteraction?.cancel();
    widget.controller?._detach(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final physics = interaction ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics();

    Widget body = ListView.custom(
      childrenDelegate: widget.delegate,
      physics: physics,
      reverse: isReverse,
      controller: controller,
      padding: widget.padding,
      scrollDirection: widget.scrollDirection,
      semanticChildCount: widget.delegate.estimatedChildCount,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    );

    if (isWebOrDesktop) {
      body = MouseRegion(
        onEnter: (_) => stop(),
        onExit: (_) => start(),
        child: body,
      );
    }

    return IgnorePointer(
      ignoring: !interaction,
      child: Listener(
        onPointerDown: onPointerDownHandler,
        onPointerUp: onPointerUpHandler,
        child: body,
      ),
    );
  }
}

class MarqueerWidgetController {
  MarqueerWidgetController();

  final _marquees = <_MarqueerWidgetState>[];

  void _attach(_MarqueerWidgetState marqueer) {
    _marquees.add(marqueer);
  }

  void _detach(_MarqueerWidgetState marqueer) {
    _marquees.remove(marqueer);
  }

  bool get hasClients => _marquees.isNotEmpty;

  bool get isAnimating {
    assert(hasClients, 'Not found any attached marqueer widget');
    assert(_marquees.length == 1, 'Multiple marqueer widget attached.');
    return _marquees.single.animating;
  }

  void start() {
    assert(hasClients, 'Not found any attached marqueer widget');
    for (var state in _marquees) {
      state.start();
    }
  }

  void stop() {
    assert(hasClients, 'Not found any attached marqueer widget');
    for (var state in _marquees) {
      state.stop();
    }
  }

  void interactionEnabled(bool enabled) {
    assert(hasClients, 'Not found any attached marqueer widget');
    for (var state in _marquees) {
      state.interactionEnabled(enabled);
    }
  }
}
