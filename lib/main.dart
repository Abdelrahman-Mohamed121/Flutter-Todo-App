import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_app.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  final bool isDarkMode = await CacheHelper.isDarkTheme();
  AuthProvider authProvider = AuthProvider();
  await authProvider.loadTokens();
  TaskProvider taskProvider = TaskProvider();
  if (authProvider.user != null) taskProvider.fetchTasks(authProvider.user!.id);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(isDarkMode: isDarkMode),
      ),
      ChangeNotifierProvider(
        create: (context) => authProvider,
      ),
      ChangeNotifierProvider(
        create: (context) => taskProvider,
      )
    ],
    child: MyApp(isDarkMode: isDarkMode),
  ));
}
