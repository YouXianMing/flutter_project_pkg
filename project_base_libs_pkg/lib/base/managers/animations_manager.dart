import 'package:flutter/material.dart';

/// 动画基类
abstract class BaseAnimationObject {}

/// 普通类型动画对象
class CurveTweenObject extends BaseAnimationObject {
  /// 曲线
  final Curve? curve;

  /// (0.0-1.0)转换后的插值
  final Tween tween;

  CurveTweenObject({required this.tween, this.curve});
}

/// 动画序列动画对象
class TweenSequenceObject<T> extends BaseAnimationObject {
  /// 动画序列(该数组不能为空)
  final List<TweenSequenceItem<T>> items;

  TweenSequenceObject({required this.items}) {
    assert(items.isNotEmpty);
  }
}

class AnimationsManager<T extends BaseAnimationObject> {
  /// 动画的控制器
  late AnimationController _controller;
  AnimationController get controller => _controller;

  /// tickerProvider
  final TickerProvider tickerProvider;

  /// 全局曲线(如果设置了这个值,则所有Map中的动画都使用这个曲线,只对CurveTweenObject有效)
  final Curve? curve;

  /// AnimationStatus.completed时的回调
  final Function? completedCallback;

  /// AnimationStatus.forward时的回调
  final Function? forwardCallback;

  /// AnimationStatus.reverse时的回调
  final Function? reverseCallback;

  /// AnimationStatus.dismissed时的回调
  final Function? dismissedCallback;

  /// 监听动画数值变化,配合setState使用
  final Function? addListener;

  /// 构建出AnimatedBuilder的函数
  AnimatedBuilder animatedBuilder({required Widget? child, required TransitionBuilder? builder}) =>
      AnimatedBuilder(animation: _controller, builder: builder!, child: child);

  /// 存储动画对象的Map
  late Map<String, Animation> _animationsMap;

  /// 将动画配置转换成key-value的形式存储于_animationsMap中
  void _accessAnimationObject(String key, T obj) {
    if (obj is CurveTweenObject) {
      if (curve != null) {
        // 如果设置了全局曲线,则所有Map中的动画都使用这个曲线
        _animationsMap[key] = obj.tween.animate(CurvedAnimation(parent: _controller, curve: curve!));
      } else {
        if (obj.curve == null) {
          // 如果Map中的动画对象没有设置曲线,则直接使用Controller的直线
          _animationsMap[key] = obj.tween.animate(_controller);
        } else {
          _animationsMap[key] = obj.tween.animate(CurvedAnimation(parent: _controller, curve: obj.curve!));
        }
      }
    } else if (obj is TweenSequenceObject) {
      // 动画序列
      _animationsMap[key] = TweenSequence(obj.items).animate(_controller);
    }
  }

  /// 从动画对象的Map中根据key值获取Animation对象
  Animation animationByKey(String key) => _animationsMap[key]!;

  /// 设置动画对象(如果存在这个key,则更新对象;如果不存在这个key,则添加对象),如果value为null,则表示删除对应的key
  AnimationsManager setAnimationObject({required String key, required T? value}) {
    if (value != null) {
      _accessAnimationObject(key, value);
    } else {
      _animationsMap.remove(key);
    }
    return this;
  }

  /// 更新动画时间
  set duration(Duration duration) => _controller.duration = duration;

  /// 更新翻转动画时间
  set reverseDuration(Duration reverseDuration) => _controller.reverseDuration = reverseDuration;

  /// 开始动画
  AnimationsManager forward({double? from}) {
    _controller.forward(from: from);
    return this;
  }

  /// 反转动画
  AnimationsManager reverse({double? from}) {
    _controller.reverse(from: from);
    return this;
  }

  /// 暂停动画
  AnimationsManager stop({bool canceled = true}) {
    _controller.stop(canceled: canceled);
    return this;
  }

  /// 执行动画到指定的值
  AnimationsManager animateTo(double target, {Duration? duration, Curve curve = Curves.linear}) {
    _controller.animateTo(target, duration: duration, curve: curve);
    return this;
  }

  /// 释放动画控制器
  void dispose() => _controller.dispose();

  AnimationsManager({
    required this.tickerProvider,
    required Duration duration,
    Duration? reverseDuration,
    required Map<String, T> animationObjectMap,
    this.completedCallback,
    this.forwardCallback,
    this.reverseCallback,
    this.dismissedCallback,
    this.addListener,
    this.curve,
  }) {
    /// 动画字典初始化
    _animationsMap = {};

    /// 控制器
    _controller = AnimationController(duration: duration, vsync: tickerProvider, reverseDuration: reverseDuration);

    /// 将动画配置转换成动画存储于动画字典当中
    animationObjectMap.forEach((key, value) => _accessAnimationObject(key, value));

    /// 监听数值变化
    if (addListener != null) {
      _controller.addListener(() => addListener!());
    }

    /// 监听状态
    if (dismissedCallback != null || forwardCallback != null || reverseCallback != null || completedCallback != null) {
      _controller.addStatusListener((status) {
        if (_controller.status == AnimationStatus.dismissed) {
          if (dismissedCallback != null) {
            dismissedCallback!();
          }
        } else if (_controller.status == AnimationStatus.forward) {
          if (forwardCallback != null) {
            forwardCallback!();
          }
        } else if (_controller.status == AnimationStatus.reverse) {
          if (reverseCallback != null) {
            reverseCallback!();
          }
        } else if (_controller.status == AnimationStatus.completed) {
          if (completedCallback != null) {
            completedCallback!();
          }
        }
      });
    }
  }
}
