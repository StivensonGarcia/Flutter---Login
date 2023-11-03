import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  final String _loggedInKey = 'loggedIn';
  final String _userKey = 'user';
  Map<String, String> userCredentials = {
    'user': '123',
    'caceres': '123',
    // Agrega más usuarios y contraseñas aquí
  };

  Future<void> login(String username, String password) async {
    // Validación de credenciales
    if (userCredentials.containsKey(username) && userCredentials[username] == password) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_loggedInKey, true);
      await prefs.setString(_userKey, username);
    } else {
      throw Exception('Credenciales inválidas'); // Puedes manejar errores de autenticación
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
    await prefs.remove(_userKey);
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  Future<String?> getLoggedInUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }
}

