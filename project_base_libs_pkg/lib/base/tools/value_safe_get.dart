/// 获取空安全泛型对象(如果值不是需要的类型,则返回空)
T? getSafeT<T>(dynamic value) {
  if (value is T) return value;
  return null;
}

/// 获取泛型对象(如果值不是需要的类型,则返回默认值)
T getT<T>(dynamic value, {required T defaultValue}) {
  if (value is T) return value;
  return defaultValue;
}

/// 使用泛型对象(如果值不是需要的类型,则call不会调用)
void useT<T>(dynamic value, Function(T) call) {
  if (value is T) call(value);
}

/// 获取安全的字符串,如果值不匹配,返回空字符串
String getSafeString(dynamic value) {
  if (value is String) return value;
  return '';
}

/// 获取安全的字符串,如果字符串为空,则返回指定的默认值
String getSafeDefaultString(dynamic value, {String defaultValue = ''}) {
  if (value is String) return value.isNotEmpty ? value : defaultValue;
  return defaultValue;
}

/// 获取安全的数组,如果值不匹配,返回空数组
List<T> getSafeList<T>(dynamic value) {
  if (value is List<T>) return value;
  return [];
}

/// 获取安全的字典,如果值不匹配,返回空字典
Map<String, dynamic> getSafeMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  return {};
}

/// 获取安全的int,如果值不匹配,返回0
int getSafeInt(dynamic value) {
  if (value is int) return value;
  return 0;
}

/// 获取安全的bool,如果值不匹配,返回false
bool getSafeBool(dynamic value) {
  if (value is bool) return value;
  return false;
}

/// 获取安全的double,如果值不匹配,返回0.0
double getSafeDouble(dynamic value) {
  if (value is double) return value;
  return 0.0;
}
