import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool? _isAuthenticated = null;
  bool _isLoading = false;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  User? get user => _user;

  bool? get isAuthenticated => _isAuthenticated;

  bool get isLoading => _isLoading;

  Future<void> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();
    var url = Uri.parse('https://dummyjson.com/auth/login');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      _user = User.fromJson(responseData);
      await _secureStorage.write(
          key: 'accessToken', value: responseData['accessToken']);
      await _secureStorage.write(
          key: 'refreshToken', value: responseData['refreshToken']);
      _isAuthenticated = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');

    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> loadTokens() async {
    final accessToken = await _secureStorage.read(key: 'accessToken');
    final refreshToken = await _secureStorage.read(key: 'refreshToken');

    if (accessToken == null || refreshToken == null) {
      _isAuthenticated = false;
      notifyListeners();
      return;
    }
    await refreshAccessToken(refreshToken);
  }

  Future<void> refreshAccessToken(String refreshToken) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'refreshToken': refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      final newAccessToken = responseData['accessToken'];

      await _secureStorage.write(key: 'accessToken', value: newAccessToken);
      var url = Uri.parse('https://dummyjson.com/auth/me');
      var userDataResponse = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $newAccessToken',
        },
      );
      if (userDataResponse.statusCode == 200) {
        final Map<String, dynamic> responseData =
            json.decode(userDataResponse.body);
        _user = User.fromJson(responseData);
        _isAuthenticated = true;
        notifyListeners();
      } else {
        await logout();
      }
    } else {
      await logout();
    }
  }
}
