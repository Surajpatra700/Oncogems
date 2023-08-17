import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static SharedPreferences? _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs!.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs!.setBool(key, value);
  }

  String getString(String key) {
    return _prefs!.getString(key) ?? "";
  }

  bool getBool(String key) {
    return _prefs!.getBool(key) ?? false;
  }

  Future<bool> remove(String key) async {
    return await _prefs!.remove(key); // Helps to remove an entry from shared preference storage
  }
}
