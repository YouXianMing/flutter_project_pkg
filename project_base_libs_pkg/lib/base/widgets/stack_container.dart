import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _StackContainerController extends GetxController {
  /// 监听count值
  final RxInt _count = 0.obs;

  /// Stack中的Widget的数组
  final List _widgetsList = [];

  /// 删除widget后是否立即更新
  late bool _removeWidgetImmediately;

  /// 插入widget
  void insertWidget(Widget? widget) {
    if (widget != null) {
      _widgetsList.add(widget);
      _updateObx();
    }
  }

  /// 删除widget
  void deleteWidget(Widget? widget) {
    if (widget != null) {
      _widgetsList.remove(widget);

      if (_removeWidgetImmediately == true) {
        _updateObx();
      } else {
        // 如果没有设置删除后立即删除,则在Stack中没有控件时才触发重新构建Stack
        if (_widgetsList.isEmpty) {
          _updateObx();
        }
      }
    }
  }

  /// 获取所有Stack中的widget
  List<Widget> widgets() {
    List<Widget> tmpList = [];

    for (dynamic element in _widgetsList) {
      tmpList.add(element);
    }

    return tmpList;
  }

  /// 更新count的值触发Obx的重新构建
  void _updateObx() => _count.value++;
}

class StackContainer extends StatelessWidget {
  final _StackContainerController _controller = _StackContainerController();

  /// 在执行了deleteWidget方法后,是否立即重新构建Stack,默认为false
  final bool removeImmediately;

  StackContainer({
    Key? key,
    this.removeImmediately = false,
  }) : super(key: key) {
    _controller._removeWidgetImmediately = removeImmediately;
  }

  /// 插入一个控件并重新构建Stack
  void insertWidget(Widget widget) => _controller.insertWidget(widget);

  /// 删除一个已经存在的控件,如果removeImmediately的值为true,则立即重建Stack
  void deleteWidget(Widget widget) => _controller.deleteWidget(widget);

  @override
  Widget build(BuildContext context) => Obx(() => Stack(children: _controller._count.value > -1 ? _controller.widgets() : <Widget>[]));
}
