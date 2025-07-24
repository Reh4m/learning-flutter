import 'package:learning_flutter/src/database/todo/index.dart';
import 'package:learning_flutter/src/models/todo_model.dart';

class TodoDao {
  static const String _tableName = 'todo';

  Future<int> insert(Map<String, dynamic> data) async {
    final db = await TodoDatabase.database;

    return db.insert(_tableName, data);
  }

  Future<List<TodoModel>> fetch() async {
    final db = await TodoDatabase.database;

    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((data) => TodoModel.fromMap(data)).toList();
  }

  Future<int> update(Map<String, dynamic> data) async {
    final db = await TodoDatabase.database;

    return db.update(
      _tableName,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  Future<int> updateStatus(int id, bool status) async {
    final db = await TodoDatabase.database;

    return db.update(
      _tableName,
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await TodoDatabase.database;

    return db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
