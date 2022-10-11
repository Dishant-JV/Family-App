import 'package:shared_preferences/shared_preferences.dart';

setStringPref(String key, String data) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(key, data);
}

Future getStringPref(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString(key);
}

setBoolPref(String key, bool data) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool(key, data);
}

Future getBoolPref(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool(key);
}
