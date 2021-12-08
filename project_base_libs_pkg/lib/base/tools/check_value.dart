// 获取空安全泛型对象(如果值不是需要的类型,则返回空)
T? getSafeT<T>(dynamic value) {
  if (value is T) return value;
  return null;
}

// 获取泛型对象(如果值不是需要的类型,则返回默认值)
T getT<T>(dynamic value, {required T defaultValue}) {
  if (value is T) return value;
  return defaultValue;
}

// 使用泛型对象(如果值不是需要的类型,则call不会调用)
void useT<T>(dynamic value, Function(T) call) {
  if (value is T) {
    call(value);
  }
}

// 检查string是否为空
bool checkStringIsEmpty(dynamic str) {
  if (str is String) {
    return str.isEmpty;
  } else if (str is String?) {
    return str == null ? true : str.isEmpty;
  } else {
    return true;
  }
}

// 检查数组是否为空
bool checkListIsEmpty(dynamic list) {
  if (list is List) {
    return list.isEmpty;
  } else if (list is List?) {
    return list == null ? true : list.isEmpty;
  } else {
    return true;
  }
}

// 检查字典是否为空
bool checkMapIsEmpty(dynamic map) {
  if (map is Map) {
    return map.isEmpty;
  } else if (map is Map?) {
    return map == null ? true : map.isEmpty;
  } else {
    return true;
  }
}

// 检查集合是否为空
bool checkSetIsEmpty(dynamic set) {
  if (set is Set) {
    return set.isEmpty;
  } else if (set is Set?) {
    return set == null ? true : set.isEmpty;
  } else {
    return true;
  }
}
