import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static late SharedPreferences _preferences;

  static Future init() async =>
    _preferences = await SharedPreferences.getInstance();

  static Future setUser(String email,String uid,String role) async{
    await _preferences.setString('email', email);
    await _preferences.setString('uid', uid);
    await _preferences.setString('role', role);
  }

  static String? getEmail() => _preferences.getString('email');
  static String? getUID() => _preferences.getString('uid');
  static String? getUserRole() => _preferences.getString('role');
}