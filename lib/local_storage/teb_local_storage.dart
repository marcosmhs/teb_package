// ignore: depend_on_referenced_packages
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class TebLocalStorage {
  static Future<bool> saveString({required String key, required String value}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return await sharedPreferences.setString(key, value);
  }

  static Future<bool> saveBool({required String key, required bool value}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.setInt(key, value ? 1 : 0);
  }

  static Future<bool> saveMap({required String key, required Map<String, dynamic> map}) async {
    return await saveString(key: key, value: jsonEncode(map));
  }

  static Future<String> readString({required String key, String defaultValue = ''}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(key) ?? defaultValue;
  }

  static Future<bool> readBool({required String key, bool defaultValue = false}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    int? result = sharedPreferences.getInt(key);
    return result == null ? defaultValue : result == 1;
  }

  static Future<Map<String, dynamic>> readMap({required String key}) async {
    try {
      return jsonDecode(await readString(key: key));
    } catch (_) {
      return {};
    }
  }

  static Future<bool> removeValue({required String key}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.remove(key);
  }
}
