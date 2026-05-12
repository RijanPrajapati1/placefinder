import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ================== General Methods ==================
  static String? getString(String key) => _prefs?.getString(key);
  static bool? getBool(String key) => _prefs?.getBool(key);
  static Future<bool> setString(String key, String value) async =>
      _prefs?.setString(key, value) ?? false;
  static Future<bool> setBool(String key, bool value) async =>
      _prefs?.setBool(key, value) ?? false;
  static Future<bool> remove(String key) async => _prefs?.remove(key) ?? false;
  static Future<bool> clear() async => _prefs?.clear() ?? false;

  // ================== Keys ==================
  static const String _keyUserId = 'user_id';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserRole = 'user_role';
  static const String _keyEmail = 'user_email';

  // ================== Save Login Data ==================
  static Future<void> saveLoginData({
    required String userId,
    required String role,
    String? email,
  }) async {
    await Future.wait([
      setString(_keyUserId, userId),
      setString(_keyUserRole, role),
      if (email != null) setString(_keyEmail, email),
      setBool(_keyIsLoggedIn, true),
    ]);
  }

  // ================== Getters ==================
  static bool isLoggedIn() {
    return _prefs?.getBool(_keyIsLoggedIn) ?? false;
  }

  static String? getUserId() => _prefs?.getString(_keyUserId);
  static String? getUserRole() => _prefs?.getString(_keyUserRole);
  static String? getEmail() => _prefs?.getString(_keyEmail);

  static bool isAdmin() {
    return getUserRole() == 'admin';
  }

  static Future<void> logout() async {
    await clear();
  }

  static Future<void> clearLoginData() async {
    await Future.wait([
      remove(_keyUserId),
      remove(_keyUserRole),
      remove(_keyEmail),
      remove(_keyIsLoggedIn),
    ]);
  }
}
