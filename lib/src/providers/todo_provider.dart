import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:learning_flutter/src/database/todo/todo_dao.dart';
import 'package:learning_flutter/src/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final _todoDao = TodoDao();

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
      _todos = await _todoDao.fetch();

      _errorMessage = "";
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reloadTodos() async {
    try {
      _todos = await _todoDao.fetch();

      _errorMessage = "";
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<int> addTodo(Map<String, dynamic> data) async {
    _isLoading = true;

    notifyListeners();

    try {
      final result = await _todoDao.insert(data);

      if (result > 0) reloadTodos();

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
      final result = await _todoDao.update(data);

      if (result > 0) reloadTodos();

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
      final result = await _todoDao.updateStatus(id, status);

      if (result > 0) reloadTodos();

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
      final result = await _todoDao.delete(id);

      if (result > 0) reloadTodos();

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
