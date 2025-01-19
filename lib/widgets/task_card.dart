import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/utils/constants.dart';

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
            context
                .read<TaskProvider>()
                .updateTaskStatus(task, !task.completed);
          },
          color: task.completed ? Colors.green : Colors.grey,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEditTaskNameDialog(context, task);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_forever_outlined),
              onPressed: () {
                _showDeleteConfirmationDialog(context, task);
              },
              color: Colors.red,
            ),
          ],
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

  void _showEditTaskNameDialog(BuildContext context, Task task) {
    TextEditingController taskController =
        TextEditingController(text: task.todo);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit task'),
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
                  context.read<TaskProvider>().updateTaskTodo(task, taskName);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a task todo')),
                  );
                }
              },
              child: Text('Update Task'),
            ),
          ],
        );
      },
    );
  }
}
