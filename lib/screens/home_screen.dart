import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("My tasks"),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.logout)),
        IconButton(
          onPressed: () {
            context.read<ThemeProvider>().toggleTheme();
          },
          icon: Icon(context.read<ThemeProvider>().isDarkMode
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined),
        )
      ],
    ));
  }
}
