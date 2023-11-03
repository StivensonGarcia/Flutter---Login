import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  final String _loggedInKey = 'loggedIn';
  final String _userKey = 'user';
  final String _dataKey = 'data'; 

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  Future<void> saveUser(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, username);
  }

  Future<String?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  // Métodos para gestionar datos adicionales
  Future<void> saveData(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dataKey, data);
  }

  Future<String?> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dataKey);
  }

  Future<void> removeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_dataKey);
  }


}
