import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SharedPreferencesUtil {
  static SharedPreferencesUtil? _singleton;
  static SharedPreferences? _prefs;
  static final Lock _lock = Lock();

  static bool _isInitialized = false;
  static bool get isInitialized => _isInitialized;

  static Future<SharedPreferencesUtil?> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          var singleton = SharedPreferencesUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  SharedPreferencesUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs != null) _isInitialized = true;
  }

  /// have key.
  static bool? haveKey(String key) => _prefs?.getKeys().contains(key);

  /// contains Key.
  static bool? containsKey(String key) => _prefs?.containsKey(key);

  /// get keys.
  static Set<String>? getKeys() => _prefs?.getKeys();

  /// remove.
  static Future<bool>? remove(String key) => _prefs?.remove(key);

  /// clear.
  static Future<bool>? clear() => _prefs?.clear();

  /// Fetches the latest values from the host platform.
  static Future<void>? reload() => _prefs?.reload();

  /// get Sp.
  static SharedPreferences? getSp() => _prefs;

  ///////////// get & set 方法 /////////////

  /// 获取对象
  static Object? getObject(String key) => _prefs?.get(key);

  /// 获取string
  static String? getString(String key) => _prefs?.getString(key);

  /// 设置string
  static Future<bool>? setString(String key, String value) => _prefs?.setString(key, value);

  /// 获取bool
  static bool? getBool(String key) => _prefs?.getBool(key);

  /// 设置bool
  static Future<bool>? setBool(String key, bool value) => _prefs?.setBool(key, value);

  /// 获取int
  static int? getInt(String key) => _prefs?.getInt(key);

  /// 设置int
  static Future<bool>? setInt(String key, int value) => _prefs?.setInt(key, value);

  /// 获取double
  static double? getDouble(String key) => _prefs?.getDouble(key);

  /// 设置double
  static Future<bool>? setDouble(String key, double value) => _prefs?.setDouble(key, value);

  /// 获取字符串数组
  static List<String>? getStringList(String key) => _prefs?.getStringList(key);

  /// 设置字符串数组
  static Future<bool>? setStringList(String key, List<String> value) => _prefs?.setStringList(key, value);
}
