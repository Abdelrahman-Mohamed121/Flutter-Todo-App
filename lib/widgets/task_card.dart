import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(task.todo),
        subtitle: Text(task.completed ? 'Done' : 'To Do'),
        trailing: Icon(
          task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.completed ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
