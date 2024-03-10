import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'kins_database.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE kins(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            id_no TEXT,
            contact TEXT,
            relation TEXT,
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertKin(Map<String, dynamic> kin) async {
    final db = await database;
    await db.insert('kins', kin);
  }

  Future<List<Map<String, dynamic>>> getKins() async {
    final db = await database;
    return db.query('kins');
  }

  Future<void> updateKin(Map<String, dynamic> kin) async {
    final db = await database;
    await db.update(
      'kins',
      kin,
      where: 'id = ?',
      whereArgs: [kin['id']],
    );
  }

  Future<void> deleteKin(int id) async {
    final db = await database;
    await db.delete(
      'kins',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
