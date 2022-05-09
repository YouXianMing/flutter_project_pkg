import 'package:flutter/material.dart';

/// 在遮罩中进行镂空用的widget
class LayoutMaskWidget extends StatelessWidget {
  /// 背景色
  final Color backgroundColor;

  /// 遮罩
  final List<Positioned> masks;

  const LayoutMaskWidget({
    Key? key,
    required this.backgroundColor,
    required this.masks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Positioned> list = [];
    var backgroundWidget = Container(decoration: const BoxDecoration(color: Colors.black, backgroundBlendMode: BlendMode.dstOut));
    list.add(Positioned.fill(child: backgroundWidget));
    list.addAll(masks);

    return ColorFiltered(
      colorFilter: ColorFilter.mode(backgroundColor, BlendMode.srcOut),
      child: Stack(children: list),
    );
  }
}
