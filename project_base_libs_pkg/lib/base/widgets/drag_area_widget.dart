import 'package:flutter/material.dart';

/// 参考资料:
/// https://stackoverflow.com/questions/65977699/how-to-create-a-movable-widget-in-flutter-such-that-is-stays-at-the-position-it

class DragAreaWidget extends StatefulWidget {
  /// 子控件
  final Widget child;

  /// 初始化位置
  final Offset? initPosition;

  const DragAreaWidget({Key? key, required this.child, this.initPosition}) : super(key: key);

  @override
  DragAreaStateStateful createState() => DragAreaStateStateful();

  /// 插入到Overlay上
  static void insertToOverlay({required BuildContext context, required Widget child, Offset? initPosition}) {
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) => DragAreaWidget(initPosition: initPosition, child: child));
    Overlay.of(context).insert(overlayEntry);
  }
}

class DragAreaStateStateful extends State<DragAreaWidget> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = widget.initPosition ?? const Offset(0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          // Positioned.fill(child: Container(color: Colors.amber.withOpacity(0.4))),
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              maxSimultaneousDrags: 1,
              feedback: widget.child,
              childWhenDragging: Opacity(opacity: 0.1, child: widget.child),
              onDragEnd: (details) {
                position = details.offset;
                if (mounted) setState(() {});
              },
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
