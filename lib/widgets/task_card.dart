import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: task.completed, onChanged: null),
        Text(
          task.todo,
          style: TextStyle(fontSize: 16.0),
        )
      ],
    );
  }
}
