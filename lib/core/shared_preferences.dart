import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ------------------ SETTERS -------------------------
  static Future<bool> setString(String key, String value) =>
      _prefs!.setString(key, value);

  static Future<bool> setInt(String key, int value) =>
      _prefs!.setInt(key, value);

  static Future<bool> setDouble(String key, double value) =>
      _prefs!.setDouble(key, value);

  static Future<bool> setBool(String key, bool value) =>
      _prefs!.setBool(key, value);

  static Future<bool> setStringList(String key, List<String> value) =>
      _prefs!.setStringList(key, value);

  // ------------------ GETTERS ------------------
  static String? getString(String key) => _prefs!.getString(key);

  static int? getInt(String key) => _prefs!.getInt(key);

  static double? getDouble(String key) => _prefs!.getDouble(key);

  static bool? getBool(String key) => _prefs!.getBool(key);

  static List<String>? getStringList(String key) => _prefs!.getStringList(key);

  // ------------------ REMOVE & CLEAR ------------------
  static Future<bool> remove(String key) => _prefs!.remove(key);

  static Future<bool> clear() => _prefs!.clear();

  ////
  static const _keyToken = 'user_token';
  static const _keyRole = 'user_role';
  static const _keyUserId = 'user_id';

  final SharedPreferences prefs;

  SharedPrefs({required this.prefs});

  // Save token
  Future<void> saveToken(String token) async {
    await prefs.setString(_keyToken, token);
  }

  // Get token
  String? getToken() {
    return prefs.getString(_keyToken);
  }

  Future<void> saveUserId(String id) async {
    await prefs.setString(_keyUserId, id);
  }

  // Get user ID
  String? getUserId() {
    return prefs.getString(_keyUserId);
  }

  // Save role
  Future<void> saveRole(String role) async {
    await prefs.setString(_keyRole, role);
  }

  // Get role
  String? getRole() {
    return prefs.getString(_keyRole);
  }

  // Clear all
  Future<void> clearTokens() async {
    await prefs.remove(_keyToken);
    await prefs.remove(_keyRole);
  }
}
