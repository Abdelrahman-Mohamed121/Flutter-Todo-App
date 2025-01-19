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
    if (response.statusCode == 201) {
      Task task = Task.fromJson(json.decode(response.body));
      _tasks.add(task);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateTask(Task task, bool completed) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('https://dummyjson.com/todos/${task.id}');
    final body = jsonEncode({
      'completed': completed,
    });
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      Task newTask = Task.fromJson(json.decode(response.body));
      int i = _tasks.indexOf(task);
      _tasks.remove(task);
      _tasks.insert(i, newTask);
    } else if (response.statusCode == 404) {
      //An added task is not actually added to the server
      int i = _tasks.indexOf(task);
      _tasks.remove(task);
      Task newTask = Task(
        id: task.id,
        completed: completed,
        todo: task.todo,
        userId: task.userId,
      );
      _tasks.insert(i, newTask);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('https://dummyjson.com/todos/${task.id}');
    final response = await http.delete(
      url,
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 404) {
      //in case of added task, it's not added to the dummy server so it's not found and return status code 404
      _tasks.remove(task);
    } 
    _isLoading = false;
    notifyListeners();
  }
}
