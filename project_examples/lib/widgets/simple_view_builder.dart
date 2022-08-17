import 'package:flutter/material.dart';

mixin _SimpleViewBuilderMixin {
  /// 更新state
  void updateState();
}

/// 简易的SimpleViewBuilder的控制器
/// 注意:此控制器需要通过final持有的方式进行初始化,每一个SimpleViewBuilder只能对应一个SimpleViewBuilderController的子类的实例
abstract class SimpleViewBuilderController {
  /// 持有SimpleViewBuilder的state
  _SimpleViewBuilderMixin? _mixinState;

  /// (abstract) 当前控制器被换成新的了,可以从oldController中获取新值进行更新
  void didUpdateBuilderController<T extends SimpleViewBuilderController>(T oldController);

  /// (子类重写) 控件的state执行了initState
  void initState() {}

  /// (子类重写) 控件的state执行了didChangeDependencies
  void didChangeDependencies() {}

  /// (子类重写) 控件的state执行了didUpdateWidget
  void didUpdateWidget<T extends SimpleViewBuilderController>(SimpleViewBuilder<T> oldWidget) {}

  /// (子类重写) 控件的state执行了dispose
  void dispose() {}

  /// 控件state执行了setState
  void update() {
    if (_mixinState != null) _mixinState!.updateState();
  }
}

class SimpleViewBuilder<T extends SimpleViewBuilderController> extends StatefulWidget {
  /// SimpleViewBuilderController的子类
  final T init;

  /// 构建出widget的builder,并将SimpleViewBuilderController的子类对象传入进去
  final Widget Function(T) builder;

  /// 构造方法
  const SimpleViewBuilder({Key? key, required this.init, required this.builder}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SimpleViewBuilderState<T>();
}

class _SimpleViewBuilderState<T extends SimpleViewBuilderController> extends State<SimpleViewBuilder<T>> with _SimpleViewBuilderMixin {
  T? currentController;

  void updateCurrentControllerAndGetMixinState() {
    if (currentController == null) {
      currentController = widget.init;
    } else {
      // 如果currentController不是最新的,则替换成最新的,并调用didUpdateBuilderController方法,通知新的控制器从旧的控制器中继承值
      if (currentController != null && currentController != widget.init) {
        widget.init.didUpdateBuilderController(currentController!);
        currentController = widget.init;
      }
    }

    widget.init._mixinState = this;
  }

  @override
  void initState() {
    super.initState();
    updateCurrentControllerAndGetMixinState();
    widget.init.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateCurrentControllerAndGetMixinState();
    widget.init.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SimpleViewBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateCurrentControllerAndGetMixinState();
    widget.init.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    widget.init.dispose();
    currentController = null;
    widget.init._mixinState = null;
  }

  @override
  Widget build(BuildContext context) => widget.builder(widget.init);

  @override
  void updateState() {
    if (mounted) setState(() {});
  }
}
