import 'package:shared_preferences/shared_preferences.dart';
import '../models/Users.dart';

class SessionManager {
  static const String _kUserIdKey = 'user_id';
  static const String _kUserNameKey = 'user_name';
  static const String _kTokenKey = 'auth_token';

  static Future<void> setUser(User user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_kUserIdKey, user.id as int);
    prefs.setString(_kUserNameKey, user.name);
    prefs.setString(_kTokenKey, token);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt(_kUserIdKey);
    final userName = prefs.getString(_kUserNameKey);


    if (userId != null && userName != null) {
      return User(id: userId.toString(), name: userName, idnum: "", phone: "", loanlimit: "", pwd: "");
    }
    return null;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kTokenKey);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_kUserIdKey);
    prefs.remove(_kUserNameKey);
    prefs.remove(_kTokenKey);
  }  
}

