import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/task_card.dart';

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
        ),
        body: Padding(
          padding: defaultPadding,
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(children: [
              TaskCard(
                  task:
                      Task(id: 1, completed: false, todo: "task1", userId: 20)),
              TaskCard(
                  task:
                      Task(id: 2, completed: true, todo: "task2", userId: 20)),
            ]),
          ),
        ));
  }
}
