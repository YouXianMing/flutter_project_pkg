import 'package:project_base_libs_pkg/base/tools/sp_val.dart';

// ------------------ 本地存储的枚举值,不需要写key名字 ------------------ //

/// 本地存储的string类型数据,没有赋值的情形默认值是''
enum AppString {
  test,
}

/// 本地存储的Int类型数据,没有赋值的情形默认值是0
enum AppInt {
  /// 当前语言,0表示未初始化,1表示英文,2表示中文
  language,
}

/// 本地存储的Double类型数据,没有赋值的情形默认值是0.0
enum AppDouble {
  test,
}

/// 本地存储的Bool类型数据,没有赋值的情形默认值是false
enum AppBool {
  /// 是否是首次启动
  isFirstLaunch,
}

// ------------------ 对枚举值的扩展,用于SpVal ------------------ //

/// 本地存储的string类型数据扩展
extension AppStringExtension on AppString {
  String get value => SpVal.get(SpString(key: toString().split('.').last));

  set value(String val) => SpVal.set(SpString(key: toString().split('.').last, value: val));
}

/// 本地存储的int类型数据扩展
extension AppIntExtension on AppInt {
  int get value => SpVal.get(SpInt(key: toString().split('.').last));

  set value(int val) => SpVal.set(SpInt(key: toString().split('.').last, value: val));
}

/// 本地存储的double类型数据扩展
extension AppDoubleExtension on AppDouble {
  double get value => SpVal.get(SpDouble(key: toString().split('.').last));

  set value(double val) => SpVal.set(SpDouble(key: toString().split('.').last, value: val));
}

/// 本地存储的bool类型数据扩展
extension AppBoolExtension on AppBool {
  bool get value => SpVal.get(SpBool(key: toString().split('.').last));

  set value(bool val) => SpVal.set(SpBool(key: toString().split('.').last, value: val));
}
