import 'package:flutter/material.dart';

/// 用于List控件上的无波纹效果的配置
ScrollConfiguration noShadowScrollConfiguration({required Widget child}) {
  return ScrollConfiguration(behavior: NoShadowScrollBehavior(), child: child);
}

// https://www.appsloveworld.com/flutter/100/1/how-to-remove-scroll-glow
class NoShadowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    // 什么也不配置
    return child;
  }
}
