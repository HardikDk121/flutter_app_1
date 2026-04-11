import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'; // Web factory
import '../../models/recipe.dart';
class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;
  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('recipes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // Switch to the WebAssembly factory when running on the web 
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    String path = filePath; // Web just uses the string name
    
    // For mobile/desktop, use the actual file system path
    if (!kIsWeb) {
      final dbPath = await getDatabasesPath();
      path = join(dbPath, filePath);
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create table
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recipes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        ingredients TEXT,
        steps TEXT,
        category TEXT,
        time TEXT,
        image TEXT
      )
    ''');
  }

  // Insert recipe
  Future<int> insertRecipe(Recipe recipe) async {
    final db = await instance.database;
    return await db.insert('recipes', recipe.toMap());
  }
}