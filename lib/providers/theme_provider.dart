import 'package:flutter/material.dart';
import 'package:todo_app/utils/cache_helper.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode;

  ThemeProvider({required this.isDarkMode}) {
    _loadTheme();
  }

  void _loadTheme() async {
    isDarkMode = await CacheHelper.isDarkTheme();
    notifyListeners();
  }

  void toggleTheme() async {
    isDarkMode = !isDarkMode;
    notifyListeners();
    await CacheHelper.saveThemeMode(isDarkMode);
  }
}
