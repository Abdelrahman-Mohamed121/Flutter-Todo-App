import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(task.todo),
        subtitle: Text(task.completed ? 'Done' : 'To Do'),
        contentPadding: EdgeInsets.zero,
        leading: IconButton(
          icon: Icon(task.completed
              ? Icons.check_circle
              : Icons.radio_button_unchecked),
          onPressed: () {
            context.read<TaskProvider>().updateTask(task, !task.completed);
          },
          color: task.completed ? Colors.green : Colors.grey,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_forever_outlined),
          onPressed: () {
            _showDeleteConfirmationDialog(context,task);
          },
          color: Colors.red,
        ),
      ),
    );
  }
  void _showDeleteConfirmationDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete this task?'),
          content: Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                context.read<TaskProvider>().deleteTask(task);
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${task.todo} deleted')),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
