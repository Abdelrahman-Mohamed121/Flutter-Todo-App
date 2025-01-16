import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const darkModeKey = 'darkModeKey';

  static late SharedPreferences prefs;
  static init() async => prefs = await SharedPreferences.getInstance();
  
  // read from shared
  static Future<bool> isDarkTheme() async =>
      prefs.getBool(darkModeKey) ?? false ;

  // save to shared
  static Future<void> saveThemeMode(bool isDarkMode) async =>
      await prefs.setBool(darkModeKey, isDarkMode);
}
