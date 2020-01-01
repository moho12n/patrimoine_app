import '../Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserOnline {
  static User user;
  static bool userIsOnline;

  Future saveUser(String name, String age, String adress, String gender,
      bool userIsOnline) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
    await prefs.setString("age", age);
    await prefs.setString("adress", adress);
    await prefs.setString("gender", gender);
    await prefs.setBool("userIsOnline", userIsOnline);
  }

  Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    user.name = await prefs.getString("name") ?? "none";
    user.age = await prefs.getString("age") ?? "none";
    user.adress = await prefs.getString("adress") ?? "none";
    user.gender = await prefs.getString("gender") ?? "none";
    userIsOnline = await prefs.getBool("userIsOnline") ?? false;
  }
}
