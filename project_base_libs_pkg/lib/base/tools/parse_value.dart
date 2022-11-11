/// 尝试将数据类型int,double,bool,string转换为double类型
double? tryParseToDouble(dynamic value) {
  if (value is double) {
    return value;
  } else if (value is int) {
    return value.toDouble();
  } else if (value is bool) {
    return (value == true ? 1.0 : 0.0);
  } else if (value is String) {
    return double.tryParse(value);
  } else {
    return null;
  }
}

/// 尝试将数据类型int,double,bool,string转换为int类型
int? tryParseToInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is double) {
    return value.toInt();
  } else if (value is bool) {
    return (value == true ? 1 : 0);
  } else if (value is String) {
    return int.tryParse(value);
  } else {
    return null;
  }
}

/// 尝试将数据类型bool,int,double,string转换为bool类型
bool? tryParseToBool(dynamic value) {
  if (value is bool) {
    return value;
  } else if (value is int) {
    return value != 0;
  } else if (value is double) {
    return value != 0.0;
  } else if (value is String) {
    var tmp = value.toLowerCase();
    if (tmp == 'true') {
      return true;
    } else if (tmp == 'false') {
      return false;
    } else {
      return null;
    }
  } else {
    return null;
  }
}
