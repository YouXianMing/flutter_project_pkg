import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
