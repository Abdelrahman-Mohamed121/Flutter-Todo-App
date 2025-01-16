import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  const MyApp({super.key, required this.isDarkMode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: context.watch<ThemeProvider>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.indigo,
          primary: Colors.indigoAccent,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.indigo,
          primary: Colors.indigoAccent,
        ),
        useMaterial3: true,
      ),
      home: context.watch<AuthProvider>().isAuthenticated == null
          ? Scaffold(body: Center(child: CircularProgressIndicator()))
          : context.watch<AuthProvider>().isAuthenticated!
              ? HomeScreen()
              : LoginScreen(),
    );
  }
}
