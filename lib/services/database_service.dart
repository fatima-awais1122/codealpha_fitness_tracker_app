import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/activity_model.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fitness_tracker.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE activities(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            activityName TEXT,
            steps INTEGER,
            calories INTEGER,
            duration INTEGER
          )
        ''');
      },
    );
  }

  // Add Activity
  static Future<int> insertActivity(ActivityModel activity) async {
    final db = await database;
    return await db.insert(
      'activities',
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // safety
    );
  }

  // Get All Activities
  static Future<List<ActivityModel>> getActivities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('activities');

    return List.generate(
      maps.length,
      (index) => ActivityModel.fromMap(maps[index]),
    );
  }

  // Delete Activity
  static Future<void> deleteActivity(int id) async {
    final db = await database;
    await db.delete('activities', where: 'id = ?', whereArgs: [id]);
  }
}
