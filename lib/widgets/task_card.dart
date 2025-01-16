import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(task.todo),
        trailing: Icon(
          task.completed ? Icons.check_circle : Icons.circle_outlined,
          color: task.completed ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}
