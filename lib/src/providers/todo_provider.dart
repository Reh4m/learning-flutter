import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:learning_flutter/src/database/todo/todo_dao.dart';
import 'package:learning_flutter/src/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final todoDao = TodoDao();

  List<TodoModel> _todos = [];
  bool _isLoading = false;
  String _errorMessage = "";

  UnmodifiableListView<TodoModel> get todos =>
      UnmodifiableListView<TodoModel>(_todos);
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> loadTodos() async {
    _isLoading = true;

    notifyListeners();

    try {
      _todos = await todoDao.fetch();

      _errorMessage = "";
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int> addTodo(Map<String, dynamic> data) async {
    _isLoading = true;

    notifyListeners();

    try {
      final result = await todoDao.insert(data);

      _errorMessage = "";

      return result;
    } catch (e) {
      _errorMessage = e.toString();

      return -1;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int> updateTodo(Map<String, dynamic> data) async {
    _isLoading = true;

    notifyListeners();

    try {
      final result = await todoDao.update(data);

      _errorMessage = "";

      return result;
    } catch (e) {
      _errorMessage = e.toString();

      return -1;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int> updateTodoStatus(int id, bool status) async {
    _isLoading = true;

    notifyListeners();

    try {
      final result = await todoDao.updateStatus(id, status);

      _errorMessage = "";

      return result;
    } catch (e) {
      _errorMessage = e.toString();

      return -1;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int> deleteTodo(int id) async {
    _isLoading = true;

    notifyListeners();

    try {
      final result = await todoDao.delete(id);

      _errorMessage = "";

      return result;
    } catch (e) {
      _errorMessage = e.toString();

      return -1;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
