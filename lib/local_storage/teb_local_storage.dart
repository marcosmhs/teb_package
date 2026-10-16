// ignore: depend_on_referenced_packages
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TebLocalStorage {
  static Future<bool> addItemToList({required String key, required String itemKey, required dynamic itemValue}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    // Recupera o mapa atual
    String? jsonString = sharedPreferences.getString(key);
    Map<String, dynamic> listaDados = {};
    if (jsonString != null && jsonString.isNotEmpty) {
      listaDados = Map<String, dynamic>.from(jsonDecode(jsonString));
    }
    // Adiciona ou atualiza o item
    listaDados[itemKey] = itemValue;
    // Salva novamente
    return await sharedPreferences.setString(key, jsonEncode(listaDados));
  }

  static Future<Map<String, dynamic>> getItemsFromList({required String key}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? jsonString = sharedPreferences.getString(key);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        return Map<String, dynamic>.from(jsonDecode(jsonString));
      } catch (e) {
        return {};
      }
    }
    return {};
  }

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
    try {
      final sharedPreferences = await SharedPreferences.getInstance();

      return sharedPreferences.getString(key) ?? defaultValue;
    } catch (e) {
      if (kDebugMode) {
        print("readString : ${e.toString()}");
      }
      return e.toString();
    }
  }

  static Future<bool> readBool({required String key, bool defaultValue = false}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    int? result = sharedPreferences.getInt(key);
    return result == null ? defaultValue : result == 1;
  }

  static Future<Map<String, dynamic>> readMap({required String key}) async {
    try {
      var r = await readString(key: key);
      return jsonDecode(r);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return {};
    }
  }

  static Future<bool> removeValue({required String key}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.remove(key);
  }
}
