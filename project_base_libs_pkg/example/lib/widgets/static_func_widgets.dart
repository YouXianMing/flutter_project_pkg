import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

/// 自定义菊花
Widget customIndicatorWidget() {
  return Container(
    color: Colors.transparent,
    child: Center(
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
          BoxShadow(
              color: Colors.grey.withAlpha(35),
              offset: const Offset(0.0, 0.0), // 阴影xy轴偏移量
              blurRadius: 8.0, // 阴影模糊程度
              spreadRadius: 2.0 // 阴影扩散程度
              )
        ]),
        width: 70,
        height: 70,
        child: const CupertinoActivityIndicator(),
      ),
    ),
  );
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? Util.randomOpaqueColor.withOpacity(0.5),
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
