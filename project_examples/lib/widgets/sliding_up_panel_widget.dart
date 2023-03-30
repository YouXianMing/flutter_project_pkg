import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/extensions/global_key_extensions.dart';
import 'package:project_base_libs_pkg/base/widgets/custom_stateful_widget_mixin.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpPanelWidgetController {
  /// 持有state
  CustomStatefulWidgetStateMixin? _stateMixin;

  /// 子组件持有的数据
  dynamic data;

  /// Panel控制器
  final PanelController panelController = PanelController();

  /// 更新子组件,并持有新的数据
  void update({dynamic data, bool calculateAgain = true, Duration calculateAgainDuration = const Duration(milliseconds: 250)}) {
    if (_stateMixin != null) {
      // 设置data
      this.data = data;

      // 更新state
      _stateMixin!.stateMixinSetState();

      // 更新最大高度
      (_stateMixin as SlidingUpPanelWidgetState).updateMaxHeight();

      // 再次更新最大高度(有时候第一次获取的高度不够准确,需要再重新获取一次)
      if (calculateAgain == true) {
        Future.delayed(calculateAgainDuration, () {
          // 更新最大高度
          (_stateMixin as SlidingUpPanelWidgetState).updateMaxHeight();
        });
      }
    }
  }
}

class SlidingUpPanelWidget extends StatefulWidget {
  /// 逻辑控制器
  final SlidingUpPanelWidgetController controller;

  /// 限定宽度,一般是屏幕宽度,必须指定
  final double fixedWidth;

  /// 指定最低高度
  final double minHeight;

  /// 是否显示Panel,默认为显示
  final bool showPanel;

  /// Widget构造器
  final Widget Function(dynamic data, bool onPanelOpened, SlidingUpPanelWidgetController controller) builder;

  const SlidingUpPanelWidget({
    Key? key,
    required this.controller,
    required this.fixedWidth,
    required this.minHeight,
    this.showPanel = true,
    required this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SlidingUpPanelWidgetState();
}

class SlidingUpPanelWidgetState extends State<SlidingUpPanelWidget> with CustomStatefulWidgetStateMixin {
  /// 用于获取组件尺寸
  final key = GlobalKey();

  /// 用以记录最大高度
  double maxHeight = 0;

  /// Panel是否打开
  bool onPanelOpened = false;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: widget.showPanel == false,
      child: SlidingUpPanel(
        body: onPanelOpened
            ? GestureDetector(
                child: Container(color: Colors.transparent),
                onTap: () => widget.controller.panelController.close(),
              )
            : const SizedBox(),
        controller: widget.controller.panelController,
        boxShadow: const [],
        color: Colors.transparent,
        minHeight: maxHeight == 0 ? 0 : widget.minHeight,
        maxHeight: maxHeight,
        onPanelOpened: () {
          if (onPanelOpened == false) setState(() {});
          onPanelOpened = true;
        },
        onPanelClosed: () {
          if (onPanelOpened == true) setState(() {});
          onPanelOpened = false;
        },
        panelBuilder: (c) {
          return UnconstrainedBox(
            child: SizedOverflowBox(
              alignment: Alignment.topCenter,
              size: Size(widget.fixedWidth, maxHeight),
              child: SizedBox(
                key: key,
                width: widget.fixedWidth,
                child: widget.builder(widget.controller.data, onPanelOpened, widget.controller),
              ),
            ),
          );
        },
      ),
    );
  }

  void updateMaxHeight() {
    // 更新最大高度
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      maxHeight = key.globalPaintBounds?.size.height ?? 0;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller._stateMixin = this;

    // 更新最大高度
    updateMaxHeight();
  }

  @override
  void didUpdateWidget(covariant SlidingUpPanelWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller._stateMixin = this;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller._stateMixin = this;
  }

  @override
  void stateMixinSetState() {
    if (mounted) setState(() {});
  }

  @override
  bool get stateMixinIsMounted => mounted;

  @override
  BuildContext get stateMixinBuildContext => context;
}
