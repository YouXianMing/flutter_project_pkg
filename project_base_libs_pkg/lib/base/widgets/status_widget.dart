import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _StatusWidgetController extends GetxController {
  static const int normal = 0;
  static const int highlighted = 1;

  /// 当前按钮状态
  final RxInt _currentState = _StatusWidgetController.normal.obs;

  /// 禁用状态
  final RxBool _disable = false.obs;

  /// 选中状态
  final RxBool _selected = false.obs;

  /// 更新
  final RxInt _update = 0.obs;

  /// 数据
  dynamic _data;

  /// 点击事件
  Function(StatusWidget)? _onTap;

  /// 普通状态构造器
  Widget Function(StatusWidget)? _normalStatusBuilder;

  /// 高亮状态构造器
  Widget Function(StatusWidget)? _highlightedStatusBuilder;

  /// 选中状态构造器
  Widget Function(StatusWidget)? _selectedStatusBuilder;

  /// 未选中状态构造器
  Widget Function(StatusWidget)? _unselectedStatusBuilder;

  /// 禁用状态构造器
  Widget Function(StatusWidget)? _disableStatusBuilder;
}

enum StatusWidgetType {
  normalButton, // 包含普通状态,高亮状态,禁用状态
  selectedButton, // 包含选中状态,未选中状态,禁选状态
}

enum StatusWidgetStatus {
  normal,
  highlighted,
  disable,
  selected,
  unselected,
}

class StatusWidget extends StatelessWidget {
  /// 控制器
  final _StatusWidgetController _controller = _StatusWidgetController();

  /// 初始化时的数据
  final dynamic initData;

  /// 点击事件
  final Function(StatusWidget)? onTap;

  /// widget类型,默认为常用按钮类型
  final StatusWidgetType type;

  /// 开始自动选中,默认为ture
  final bool enableAutoSelect;

  /// 初始化选中状态(默认为false),只在StatusWidgetType.selectedButton下生效
  final bool initSelectValue;

  /// 初始化禁用状态(默认为false)
  final bool initDisableValue;

  /// StatusWidgetType.normalButton类型Normal状态下的widget构造器,如果是StatusWidgetType.normalButton,则必须得有这个对象
  final Widget Function(StatusWidget)? normalStatusBuilder;

  /// StatusWidgetType.normalButton类型Highlighted状态下的widget构造器,如果为空,则使用normalStatusBuilder
  final Widget Function(StatusWidget)? highlightedStatusBuilder;

  /// StatusWidgetType.selectedButton类型选中状态下的widget构造器,如果是StatusWidgetType.selectedButton,则必须有这个对象
  final Widget Function(StatusWidget)? selectedStatusBuilder;

  /// StatusWidgetType.selectedButton类型未选中状态下的widget构造器,如果是StatusWidgetType.selectedButton,则必须有这个对象
  final Widget Function(StatusWidget)? unselectedStatusBuilder;

  /// 通用类型禁用状态下的widget构造器
  final Widget Function(StatusWidget)? disableStatusBuilder;

  StatusWidget({
    Key? key,
    this.initData,
    this.onTap,
    this.type = StatusWidgetType.normalButton,
    this.enableAutoSelect = false,
    this.initSelectValue = false,
    this.initDisableValue = false,
    this.normalStatusBuilder,
    this.highlightedStatusBuilder,
    this.selectedStatusBuilder,
    this.unselectedStatusBuilder,
    this.disableStatusBuilder,
  }) : super(key: key) {
    setOnTap(onTap);
    setData(initData);
    setSelect(initSelectValue);
    setDisable(initDisableValue);
    setHighlightedStatusBuilder(highlightedStatusBuilder);
    setDisableStatusBuilder(disableStatusBuilder);
    if (type == StatusWidgetType.normalButton) {
      setNormalStatusBuilder(normalStatusBuilder);
    } else if (type == StatusWidgetType.selectedButton) {
      setSelectedStatusBuilder(selectedStatusBuilder);
      setUnselectedStatusBuilder(unselectedStatusBuilder);
    }
  }

  static StatusWidget normalButton({
    Key? key,
    dynamic initData,
    Function(StatusWidget)? onTap,
    @required Widget Function(StatusWidget)? normalStatusBuilder,
    Widget Function(StatusWidget)? highlightedStatusBuilder,
    Widget Function(StatusWidget)? disableStatusBuilder,
    bool initDisableValue = false,
  }) {
    return StatusWidget(
      key: key,
      type: StatusWidgetType.normalButton,
      initData: initData,
      onTap: onTap,
      normalStatusBuilder: normalStatusBuilder,
      highlightedStatusBuilder: highlightedStatusBuilder,
      disableStatusBuilder: disableStatusBuilder,
      initDisableValue: initDisableValue,
    );
  }

  static StatusWidget selectedButton({
    Key? key,
    dynamic initData,
    Function(StatusWidget)? onTap,
    @required Widget Function(StatusWidget)? selectedStatusBuilder,
    @required Widget Function(StatusWidget)? unselectedStatusBuilder,
    Widget Function(StatusWidget)? disableStatusBuilder,
    bool initDisableValue = false,
    bool enableAutoSelect = false,
    bool initSelectValue = false,
  }) {
    return StatusWidget(
      key: key,
      type: StatusWidgetType.selectedButton,
      initData: initData,
      onTap: onTap,
      selectedStatusBuilder: selectedStatusBuilder,
      unselectedStatusBuilder: unselectedStatusBuilder,
      disableStatusBuilder: disableStatusBuilder,
      initDisableValue: initDisableValue,
      enableAutoSelect: enableAutoSelect,
      initSelectValue: initSelectValue,
    );
  }

  /// (set) 设置anTap事件
  Function(StatusWidget)? get _getOnTap => _controller._onTap;
  StatusWidget setOnTap(Function(StatusWidget)? onTap) {
    _controller._onTap = onTap;
    return this;
  }

  /// (set) 设置normalStatusBuilder
  Widget Function(StatusWidget)? get _getNormalStatusBuilder => _controller._normalStatusBuilder;
  StatusWidget setNormalStatusBuilder(Widget Function(StatusWidget)? normalStatusBuilder) {
    assert(normalStatusBuilder != null);
    _controller._normalStatusBuilder = normalStatusBuilder;
    return this;
  }

  /// (set) 设置highlightedStatusBuilder
  Widget Function(StatusWidget)? get _getHighlightedStatusBuilder => _controller._highlightedStatusBuilder;
  StatusWidget setHighlightedStatusBuilder(Widget Function(StatusWidget)? highlightedStatusBuilder) {
    _controller._highlightedStatusBuilder = highlightedStatusBuilder;
    return this;
  }

  /// (set) 设置selectedStatusBuilder
  Widget Function(StatusWidget)? get _getSelectedStatusBuilder => _controller._selectedStatusBuilder;
  StatusWidget setSelectedStatusBuilder(Widget Function(StatusWidget)? selectedStatusBuilder) {
    assert(selectedStatusBuilder != null);
    _controller._selectedStatusBuilder = selectedStatusBuilder;
    return this;
  }

  /// (set) 设置unselectedStatusBuilder
  Widget Function(StatusWidget)? get _getUnselectedStatusBuilder => _controller._unselectedStatusBuilder;
  StatusWidget setUnselectedStatusBuilder(Widget Function(StatusWidget)? unselectedStatusBuilder) {
    assert(unselectedStatusBuilder != null);
    _controller._unselectedStatusBuilder = unselectedStatusBuilder;
    return this;
  }

  /// (set) 设置disableStatusBuilder
  Widget Function(StatusWidget)? get _getDisableStatusBuilder => _controller._disableStatusBuilder;
  StatusWidget setDisableStatusBuilder(Widget Function(StatusWidget)? disableStatusBuilder) {
    _controller._disableStatusBuilder = disableStatusBuilder;
    return this;
  }

  /// (get_set) 禁用状态的get,set方法
  bool get disable => _controller._disable.value;
  StatusWidget setDisable(bool disable) {
    _controller._disable.value = disable;
    return this;
  }

  /// (get_set) 选中状态的get,set方法
  bool get selected => _controller._selected.value;
  StatusWidget setSelect(bool select) {
    _selectedButtonStatusChangeTo(select);
    return this;
  }

  /// (get_set) 数据的get,set方法
  dynamic get data => _controller._data;
  StatusWidget setData(dynamic data) {
    _controller._data = data;
    return this;
  }

  /// 主动更新内容,比如设置了data后想立即更新内容可以调用此方法
  StatusWidget update() {
    _controller._update.value += 1;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// 如果开启了自动选择,则自动选中
        if (type == StatusWidgetType.selectedButton && enableAutoSelect == true) {
          setSelect(!selected);
        }

        if (_getOnTap != null && disable == false) {
          _getOnTap!(this);
        }
      },
      onTapCancel: () => _normalButtonStatusChangeTo(_StatusWidgetController.normal),
      onTapDown: (_) => _normalButtonStatusChangeTo(_StatusWidgetController.highlighted),
      onTapUp: (_) => _normalButtonStatusChangeTo(_StatusWidgetController.normal),
      child: Obx(() {
        /// 为了能实时刷新用
        if (_controller._update.value > 0) {}
        if (type == StatusWidgetType.normalButton) {
          if (disable == false) {
            if (_controller._currentState.value == _StatusWidgetController.normal) {
              return _getNormalStatusBuilder!(this);
            } else if (_controller._currentState.value == _StatusWidgetController.highlighted) {
              if (_getHighlightedStatusBuilder != null) {
                return _getHighlightedStatusBuilder!(this);
              } else {
                return _getNormalStatusBuilder!(this);
              }
            }
          } else {
            if (_getDisableStatusBuilder != null) {
              return _getDisableStatusBuilder!(this);
            } else {
              return _getNormalStatusBuilder!(this);
            }
          }
        } else if (type == StatusWidgetType.selectedButton) {
          if (disable == false) {
            if (_controller._selected.value == true) {
              return _getSelectedStatusBuilder!(this);
            } else {
              return _getUnselectedStatusBuilder!(this);
            }
          } else {
            if (_getDisableStatusBuilder != null) {
              return _getDisableStatusBuilder!(this);
            } else {
              return _getUnselectedStatusBuilder!(this);
            }
          }
        }

        return const SizedBox();
      }),
    );
  }

  void _normalButtonStatusChangeTo(int status) {
    if (type == StatusWidgetType.normalButton) {
      if (disable == false) {
        _controller._currentState.value = status;
      }
    }
  }

  void _selectedButtonStatusChangeTo(bool select) {
    if (type == StatusWidgetType.selectedButton) {
      if (disable == false) {
        _controller._selected.value = select;
      }
    }
  }
}
