import 'dart:convert';

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

  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    StorageService().setString("user_profile", jsonEncode(profile));
    // //_profile(profile);
    // setToken(profile.accessToken!);
  }
}

class UserLoginResponseEntity {
  String? accessToken;
  String? displayName;
  String? email;
  String? photoUrl;

  UserLoginResponseEntity({
    this.accessToken,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  UserLoginResponseEntity.fromJson(Map<String, dynamic> json) {
    UserLoginResponseEntity(
      accessToken: json["access_token"],
      displayName: json["display_name"],
      email: json["email"],
      photoUrl: json["photoUrl"],
    );
  }
  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "email": email,
        "photoUrl": photoUrl,
      };
}
