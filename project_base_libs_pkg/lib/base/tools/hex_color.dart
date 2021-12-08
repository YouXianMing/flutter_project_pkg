import 'package:flutter/material.dart';

// https://pub.flutter-io.cn/packages/hexcolor

// [HexColor]
// How to use:
// HexColor("b74093");
// HexColor("#b74093");
// HexColor("#88b74093"); // if you wish to use ARGB format

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ColorToHex extends Color {
  // convert material colors to HexColor
  static int _convertColorTHex(Color color) {
    var hex = '${color.value}';
    return int.parse(
      hex,
    );
  }

  ColorToHex(final Color color) : super(_convertColorTHex(color));
}
