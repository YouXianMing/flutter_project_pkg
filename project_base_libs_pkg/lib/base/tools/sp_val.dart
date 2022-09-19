import 'package:project_base_libs_pkg/base/tools/shared_preferences_util.dart';

/// SpVal支持的type
enum SpValType { bool, int, double, string, stringList }

/// SpVal
class SpVal {
  /// initialized's flag
  static bool _didInitialized = false;

  /// initialized, put it in main().
  static Future initialized() {
    _didInitialized = true;
    return SharedPreferencesUtil.getInstance();
  }

  /// set value.
  static Future<bool>? set<T extends SpAbstractValue>(T model) {
    if (_didInitialized == false) throw Exception('SpVal 必须先初始化后再使用');
    switch (model.type) {
      case SpValType.bool:
        return SharedPreferencesUtil.setBool(model.key, model.value ?? model.defaultValue);
      case SpValType.int:
        return SharedPreferencesUtil.setInt(model.key, model.value ?? model.defaultValue);
      case SpValType.double:
        return SharedPreferencesUtil.setDouble(model.key, model.value ?? model.defaultValue);
      case SpValType.string:
        return SharedPreferencesUtil.setString(model.key, model.value ?? model.defaultValue);
      case SpValType.stringList:
        return SharedPreferencesUtil.setStringList(model.key, model.value ?? model.defaultValue);
    }
  }

  /// get value.
  static dynamic get<T extends SpAbstractValue>(T model) {
    if (_didInitialized == false) throw Exception('SpVal 必须先初始化后再使用');
    switch (model.type) {
      case SpValType.bool:
        return SharedPreferencesUtil.getBool(model.key) ?? model.defaultValue;
      case SpValType.int:
        return SharedPreferencesUtil.getInt(model.key) ?? model.defaultValue;
      case SpValType.double:
        return SharedPreferencesUtil.getDouble(model.key) ?? model.defaultValue;
      case SpValType.string:
        return SharedPreferencesUtil.getString(model.key) ?? model.defaultValue;
      case SpValType.stringList:
        return SharedPreferencesUtil.getStringList(model.key) ?? model.defaultValue;
    }
  }
}

/// SpAbstractModel
abstract class SpAbstractValue {
  /// key值
  String get key;
  set key(String val);

  /// value值
  dynamic get value;
  set value(dynamic val);

  /// 默认值
  dynamic get defaultValue;

  /// 类型
  SpValType get type;
}

/// SpBool ///
class SpBool extends SpAbstractValue {
  @override
  String key;

  @override
  dynamic value;

  @override
  bool get defaultValue => false; // 默认值是false

  @override
  SpValType get type => SpValType.bool;

  SpBool({required this.key, this.value});
}

/// SpString ///
class SpString extends SpAbstractValue {
  @override
  String key;

  @override
  dynamic value;

  @override
  String get defaultValue => ''; // 默认值是''

  @override
  SpValType get type => SpValType.string;

  SpString({required this.key, this.value});
}

/// SpStringList ///
class SpStringList extends SpAbstractValue {
  @override
  String key;

  @override
  dynamic value;

  @override
  List<String> get defaultValue => <String>[]; // 默认值是[]

  @override
  SpValType get type => SpValType.stringList;

  SpStringList({required this.key, this.value});
}

/// SpInt ///
class SpInt extends SpAbstractValue {
  @override
  String key;

  @override
  dynamic value;

  @override
  int get defaultValue => 0; // 默认值是0

  @override
  SpValType get type => SpValType.int;

  SpInt({required this.key, this.value});
}

/// SpDouble ///
class SpDouble extends SpAbstractValue {
  @override
  String key;

  @override
  dynamic value;

  @override
  double get defaultValue => 0.0; // 默认值是0.0

  @override
  SpValType get type => SpValType.double;

  SpDouble({required this.key, this.value});
}
