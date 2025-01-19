import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  bool _isLoading = true;
  int _currentPage = 0;

  final int _limit = 10;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  void clearTasks() {
    _currentPage = 0;
    _tasks.clear();
  }

  Future<void> fetchTasks(int userId) async {
    _isLoading = true;
    notifyListeners();
    final url =
        'https://dummyjson.com/todos/user/$userId?limit=$_limit&skip=$_currentPage';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Task> loadedTasks = [];
      for (var task in data['todos']) {
        loadedTasks.add(Task.fromJson(task));
      }
      _tasks.addAll(loadedTasks);
      _currentPage += _limit;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(Task newTask) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('https://dummyjson.com/todos/add');
    final body = jsonEncode({
      'todo': newTask.todo,
      'completed': false,
      'userId': newTask.userId,
    });
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      Task task = Task.fromJson(json.decode(response.body));
      _tasks.add(task);
    }
    print(_tasks);
    _isLoading = false;
    notifyListeners();
  }
}
