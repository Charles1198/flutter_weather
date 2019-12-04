import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static SharedPreferences sp;

  static Future init() async {
    if (sp == null) {
      sp = await SharedPreferences.getInstance();
    }
  }

  /// 增
  static Future setString(String key, String value) async {
    await init();
    sp.setString(key, value);
  }

  static Future setInt(String key, int value) async {
    await init();
    sp.setInt(key, value);
  }

  static Future setBool(String key, bool value) async {
    await init();
    sp.setBool(key, value);
  }

  static Future setDouble(String key, double value) async {
    await init();
    sp.setDouble(key, value);
  }

  static Future setStringList(String key, List<String> value) async {
    await init();
    sp.setStringList(key, value);
  }

  /// 删
  static Future remove(String key) async {
    await init();
    sp.remove(key);
  }

  static Future clear() async {
    await init();
    sp.clear();
  }

  /// 查
  static Future<String> getString(String key) async {
    await init();
    return sp.getString(key) ?? '';
  }

  static Future<int> getInt(String key)  async {
    await init();
    return sp.getInt(key) ?? 0;
  }

  static Future<bool> getBool(String key) async {
    await init();
    return sp.getBool(key) ?? false;
  }

  static Future<double> getDouble(String key) async {
    await init();
    return sp.getDouble(key) ?? 0.0;
  }

  static Future<List<String>> getStringList(String key) async {
    await init();
    return sp.getStringList(key) ?? List();
  }

  /// 判空
  static Future<bool> existsValue(String key) async {
    await init();
    return sp.getKeys().contains(key);
  }
}
