import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_app.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  final bool isDarkMode = await CacheHelper.isDarkTheme();
  AuthProvider provider = AuthProvider();
  await provider.loadTokens();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(isDarkMode: isDarkMode),
      ),
      ChangeNotifierProvider(
        create: (context) => provider,
      )
    ],
    child: MyApp(isDarkMode: isDarkMode),
  ));
}
