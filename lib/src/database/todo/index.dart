import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  static const _dbName = 'todo.db';
  static const _dbVersion = 1;
  static const _tableName = 'todo';

  static final TodoDatabase _instance = TodoDatabase._internal();
  static Database? _database;

  factory TodoDatabase() => _instance;

  TodoDatabase._internal();

  static Future<Database> get database async {
    if (_database != null) return _database!;

    return _database = await _initDatabase();
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);

    return openDatabase(path, version: _dbVersion, onCreate: _createDatabase);
  }

  static Future<void> _createDatabase(Database db, int version) async {
    String query = '''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title VARCHAR(255),
            description TEXT,
            date VARCHAR(16),
            status BOOLEAN
          )
        ''';

    db.execute(query);
  }
}
