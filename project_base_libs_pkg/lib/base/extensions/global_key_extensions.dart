import 'package:flutter/material.dart';

extension GlobalKeyExtensions on GlobalKey {
  /// 获取Rect
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null) {
      return renderObject!.paintBounds.shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }

  /// 获取坐标的中心点
  Offset? get globalPaintCenterPoint {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null) {
      return renderObject!.paintBounds.shift(Offset(translation.x, translation.y)).center;
    } else {
      return null;
    }
  }

  /// 是否是RenderBox
  bool get isRenderBox => currentContext?.findRenderObject() is RenderBox;

  /// RenderBox的绝对坐标(首先确保是RenderBox,否则会报错)
  Offset get renderBoxLocalToGlobalOffset {
    RenderBox box = currentContext!.findRenderObject()! as RenderBox;
    return box.localToGlobal(Offset.zero);
  }
}
