/// 尝试将数据int或者double类型数据转换为double类型
double? tryParseToDouble(dynamic value) {
  if (value is double) {
    return value;
  } else if (value is int) {
    return value.toDouble();
  } else {
    return null;
  }
}

/// 尝试将数据int或者double类型数据转换为int类型
int? tryParseToInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is double) {
    return value.toInt();
  } else {
    return null;
  }
}

/// 尝试将数据bool,double,或者int转换为bool类型
bool? tryParseToBool(dynamic value) {
  if (value is bool) {
    return value;
  } else if (value is int) {
    return value != 0;
  } else if (value is double) {
    return value != 0.0;
  } else {
    return null;
  }
}
