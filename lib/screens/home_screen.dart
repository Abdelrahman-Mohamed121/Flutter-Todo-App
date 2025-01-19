import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/task_card.dart';

import '../models/task.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<AuthProvider>().user == null) return LoginScreen();

    final userId = context.read<AuthProvider>().user!.id;

    _scrollController.addListener(() {
      final taskProvider = context.read<TaskProvider>();
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          taskProvider.tasks.isNotEmpty) {
        if (!taskProvider.isLoading) {
          taskProvider.fetchTasks(userId);
        }
      }
    });

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
                  backgroundImage: context
                          .read<AuthProvider>()
                          .user!
                          .image
                          .isNotEmpty
                      ? NetworkImage(context.read<AuthProvider>().user!.image)
                      : AssetImage('assets/profile.jpg'),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                context.read<AuthProvider>().logout();
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
        child: context.watch<TaskProvider>().isLoading &&
                context.watch<TaskProvider>().tasks.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : context.watch<TaskProvider>().tasks.isEmpty
                ? const Center(child: Text('No tasks available.'))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: context.watch<TaskProvider>().tasks.length +
                        (context.watch<TaskProvider>().isLoading ? 1 : 0),
                    itemBuilder: (ctx, index) {
                      if (index >= context.watch<TaskProvider>().tasks.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return TaskCard(
                          task: context.watch<TaskProvider>().tasks[index]);
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context, context.read<TaskProvider>());
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, TaskProvider taskProvider) {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a task'),
          content: TextFormField(
            controller: taskController,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: defaultBorder),
              labelText: "To do",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String taskName = taskController.text.trim();
                if (taskName.isNotEmpty) {
                  Task newTask = Task(
                      todo: taskName,
                      completed: false,
                      userId: context.read<AuthProvider>().user!.id);
                  taskProvider.addTask(newTask);
                  Navigator.pop(context); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a task todo')),
                  );
                }
              },
              child: Text('Add Task'),
            ),
          ],
        );
      },
    );
  }
}
