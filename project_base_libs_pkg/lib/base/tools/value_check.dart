/// 检查string是否为空
bool checkStringIsEmpty(dynamic str) {
  if (str is String) {
    return str.isEmpty;
  } else if (str is String?) {
    return str == null ? true : str.isEmpty;
  } else {
    return true;
  }
}

/// 检查string是否不为空
bool checkStringIsNotEmpty(dynamic str) {
  if (str is String) {
    return str.isNotEmpty;
  } else if (str is String?) {
    return str == null ? false : str.isNotEmpty;
  } else {
    return false;
  }
}

/// 检查数组是否为空
bool checkListIsEmpty(dynamic list) {
  if (list is List) {
    return list.isEmpty;
  } else if (list is List?) {
    return list == null ? true : list.isEmpty;
  } else {
    return true;
  }
}

/// 检查数组T是否为空
bool checkListTypeIsEmpty<T>(dynamic list) {
  if (list is List<T>) return list.isEmpty;
  return true;
}

/// 检查数组是否不为空
bool checkListIsNotEmpty(dynamic list) {
  if (list is List) {
    return list.isNotEmpty;
  } else if (list is List?) {
    return list == null ? false : list.isNotEmpty;
  } else {
    return false;
  }
}

/// 检查数组T是否不为空
bool checkListTypeIsNotEmpty<T>(dynamic list) {
  if (list is List<T>) return list.isNotEmpty;
  return false;
}

/// 检查字典是否为空
bool checkMapIsEmpty(dynamic map) {
  if (map is Map) {
    return map.isEmpty;
  } else if (map is Map?) {
    return map == null ? true : map.isEmpty;
  } else {
    return true;
  }
}

/// 检查字典是否不为空
bool checkMapIsNotEmpty(dynamic map) {
  if (map is Map) {
    return map.isNotEmpty;
  } else if (map is Map?) {
    return map == null ? false : map.isNotEmpty;
  } else {
    return false;
  }
}

/// 检查集合是否为空
bool checkSetIsEmpty(dynamic set) {
  if (set is Set) {
    return set.isEmpty;
  } else if (set is Set?) {
    return set == null ? true : set.isEmpty;
  } else {
    return true;
  }
}

/// 检查集合是否不为空
bool checkSetIsNotEmpty(dynamic set) {
  if (set is Set) {
    return set.isNotEmpty;
  } else if (set is Set?) {
    return set == null ? false : set.isNotEmpty;
  } else {
    return false;
  }
}
