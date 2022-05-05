import 'package:flutter/material.dart';

/// 参考了lazy_load_indexed_stack并对其源码进行了修改,达到可以动态修改children的效果
/// https://github.com/okaryo/lazy_load_indexed_stack

/// 一个懒加载版本的[IndexedStack]
class LazyLoadIndexedStack extends StatefulWidget {
  /// 没有加载过时显示的默认额控件,默认是[Container]
  final Widget? unloadWidget;

  /// 与[IndexedStack]中的alignment一致
  final AlignmentGeometry alignment;

  /// 与[IndexedStack]中的sizing一致
  final StackFit sizing;

  /// 与[IndexedStack]中的textDirection一致
  final TextDirection? textDirection;

  /// 与[IndexedStack]中的index一致
  final int index;

  /// 待显示的控件,如果当前没有显示,则默认使用的是[unloadWidget]对其进行占位,设定了index后才会显示控件,达到懒加载的效果
  final List<Widget> children;

  /// Creates LazyLoadIndexedStack that wraps IndexedStack.
  const LazyLoadIndexedStack({
    Key? key,
    this.unloadWidget,
    this.alignment = AlignmentDirectional.topStart,
    this.sizing = StackFit.loose,
    this.textDirection,
    required this.index,
    required this.children,
  }) : super(key: key);

  @override
  _LazyLoadIndexedStackState createState() => _LazyLoadIndexedStackState();
}

class _LazyLoadIndexedStackState extends State<LazyLoadIndexedStack> {
  /// 存储children是否加载过的数组
  List<_LoadedItem> _alreadyLoadedItems = [];

  /// widget是child,int是对应的index值,为了控制遍历数组时时间复杂度为O(1)
  final Map<Widget, int> _oldChildrenIndexMap = {};

  @override
  void initState() {
    super.initState();
    // 存储加载的控件
    for (int i = 0; i < widget.children.length; i++) {
      _alreadyLoadedItems.add(_LoadedItem(child: widget.children[i], loaded: i == widget.index));
    }

    _updateNewChildrenMap();
  }

  @override
  void didUpdateWidget(final LazyLoadIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    List<_LoadedItem> newItems = [];
    for (int i = 0; i < widget.children.length; i++) {
      // 判断之前set中的widget与现在的widget是否一致
      int? index = _oldChildrenIndexMap[widget.children[i]];
      bool sameWidget = (index != null);
      if (sameWidget) {
        // 如果是相同的widget,则直接存储以前的item
        newItems.add(_alreadyLoadedItems[index]);
      } else {
        // 如果不是相同的widget,则直接设置成未加载状态
        newItems.add(_LoadedItem(child: widget.children[i], loaded: false));
      }
    }

    _updateNewChildrenMap();

    _alreadyLoadedItems = newItems;
    _alreadyLoadedItems[widget.index].loaded = true;
  }

  @override
  Widget build(final BuildContext context) {
    return IndexedStack(
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: _loadedChildren(),
    );
  }

  /// 更新_alreadyLoadedItems数组中的元素
  void _updateNewChildrenMap() {
    _oldChildrenIndexMap.clear();
    for (int i = 0; i < widget.children.length; i++) {
      _oldChildrenIndexMap[widget.children[i]] = i;
    }
  }

  /// 获取当前的children
  List<Widget> _loadedChildren() {
    List<Widget> list = [];
    for (var value in _alreadyLoadedItems) {
      list.add(value.loaded ? value.child : (widget.unloadWidget ?? Container()));
    }
    return list;
  }
}

/// 存储控件是否加载过的信息
class _LoadedItem {
  /// 子控件
  Widget child;

  /// 标记是否加载过
  bool loaded = false;
  _LoadedItem({required this.child, this.loaded = false});
}
