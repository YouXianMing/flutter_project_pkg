import 'package:flutter/material.dart';

/// Indicator配置的基类,需要实现indicator方法提供控件
abstract class BaseIndicatorConfig {
  /// 提供indicator的控件
  Widget get indicator;
}

/// 这是一个Indicator的容器类,使用了外观设计模式,隐藏各个不同的indicator的细节,提供统一的使用接口
class IndicatorWidget<T extends BaseIndicatorConfig> extends StatelessWidget {
  /// indicator的配置
  final T config;

  const IndicatorWidget({Key? key, required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) => config.indicator;
}
