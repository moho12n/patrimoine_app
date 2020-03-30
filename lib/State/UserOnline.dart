import '../Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserOnline {
  static User user;
  static bool userIsOnline;
  static int numberOfMarkers;
}

Future saveUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("name", UserOnline.user.name);
  await prefs.setString("age", UserOnline.user.age);
  await prefs.setString("adress", UserOnline.user.adress);
  await prefs.setString("gender", UserOnline.user.gender);
  await prefs.setBool("userIsOnline", UserOnline.userIsOnline);
}

Future getUser() async {
  final prefs = await SharedPreferences.getInstance();
  UserOnline.user.name = await prefs.getString("name") ?? "none";
  UserOnline.user.age = await prefs.getString("age") ?? "none";
  UserOnline.user.adress = await prefs.getString("adress") ?? "none";
  UserOnline.user.gender = await prefs.getString("gender") ?? "none";
  UserOnline.userIsOnline = await prefs.getBool("userIsOnline") ?? false;
}

saveNumberOfMarkers() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt("numberOfMarkers", UserOnline.numberOfMarkers);
}

getNumberOfMarkers() async {
  final prefs = await SharedPreferences.getInstance();
  var i;
  i = await prefs.getInt("numberOfMarkers");
  if (i != null) UserOnline.numberOfMarkers = i;
}
