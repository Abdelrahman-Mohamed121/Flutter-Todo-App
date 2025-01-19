import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  final bool isDarkMode;

  final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF86B2D8),  // Primary color (purple)
  buttonTheme: ButtonThemeData(buttonColor: Color(0xFF00BCD4)),
  appBarTheme: AppBarTheme(
    color: Color(0xFF86B2D8),  // AppBar background (primary color)
    iconTheme: IconThemeData(color: Colors.white),
    
  ),
  scaffoldBackgroundColor: Color(0xFFF5F5F5),  // Light grey background
  iconTheme: IconThemeData(color: Colors.black),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF1E88E5),
  buttonTheme: ButtonThemeData(buttonColor: Color(0xFF00ACC1)),
  appBarTheme: AppBarTheme(
    color: Color(0xFF1E88E5),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  scaffoldBackgroundColor: Color(0xFF121212),
  iconTheme: IconThemeData(color: Colors.white),
);
  MyApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: context.watch<ThemeProvider>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: context.watch<AuthProvider>().isLoading
          ? Scaffold(body: Center(child: CircularProgressIndicator()))
          : context.watch<AuthProvider>().isAuthenticated
              ? HomeScreen()
              : LoginScreen(),
    );
  }
}
