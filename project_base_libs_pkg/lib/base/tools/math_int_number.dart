class MathIntNumber {
  /// 数字
  int value;

  /// 显示位数,默认值为0,表示不生效
  int displayDigits;

  MathIntNumber({required this.value, this.displayDigits = 0});

  /// 十六进制字符串
  String get hexString => value.toRadixString(16).toUpperCase().padLeft(displayDigits, '0');

  /// 十进制字符串
  String get decimalString => value.toRadixString(10).toUpperCase().padLeft(displayDigits, '0');

  /// 八进制字符串
  String get octalString => value.toRadixString(8).toUpperCase().padLeft(displayDigits, '0');

  /// 二进制字符串
  String get binaryString => value.toRadixString(2).toUpperCase().padLeft(displayDigits, '0');

  /// 重载+
  MathIntNumber operator +(MathIntNumber m) => MathIntNumber(value: value + m.value, displayDigits: displayDigits);

  /// 重载-
  MathIntNumber operator -(MathIntNumber m) => MathIntNumber(value: value - m.value, displayDigits: displayDigits);
}
