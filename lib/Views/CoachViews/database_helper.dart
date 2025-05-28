import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('appointments.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE appointments(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        coachID INTEGER NOT NULL,
        day TEXT NOT NULL,
        startHour TEXT NOT NULL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getAppointments() async {
    final db = await instance.database;
    return await db.query('appointments', orderBy: 'day ASC, startHour ASC');
  }

  Future<int> addAppointment(Map<String, dynamic> appointment) async {
    final db = await instance.database;
    return await db.insert('appointments', appointment);
  }

  Future<int> deleteAppointment(int id) async {
    final db = await instance.database;
    return await db.delete('appointments', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
