import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/auth_provider.dart';
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
          automaticallyImplyLeading: false,
          titleTextStyle: Theme.of(context).textTheme.bodyMedium,
          titleSpacing: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 8.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: Padding(
              padding: defaultPadding,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.0,
                    backgroundColor: Colors.amber,
                  ),
                  defaultHorizontalSizedBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hi,',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          context.watch<AuthProvider>().user?.firstName ?? "",
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actionsIconTheme: Theme.of(context).iconTheme,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthProvider>().logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                icon: Icon(Icons.logout)),
            defaultHorizontalSizedBox,
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
