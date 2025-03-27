import 'dart:io';

import 'package:learning_flutter/src/models/todo_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TodoProvider {
  static const _dbName = 'todo.db';
  static const _dbVersion = 1;
  static const _tableName = 'todo';

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    return _database = await initDatabase();
  }

  Future<Database?> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) {
        String query = '''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title VARCHAR(255),
            description TEXT,
            date VARCHAR(16),
            status VARCHAR(16)
          )
        ''';

        db.execute(query);
      },
    );
  }

  Future<int> insert(Map<String, dynamic> data) async {
    final db = await database;

    return db!.insert(_tableName, data);
  }

  Future<List<TodoModel>> fetch() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableName);

    return results.map((data) => TodoModel.fromMap(data)).toList();
  }

  Future<int> update(Map<String, dynamic> data) async {
    final db = await database;

    return db!.update(
      _tableName,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;

    return db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
