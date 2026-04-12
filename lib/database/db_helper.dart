import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart'; 
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'; 
import '../models/recipe.dart'; // Ensure the path is correct

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
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    String path = filePath; 
    
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

  Future<int> insertRecipe(Recipe recipe) async {
    final db = await instance.database;
    return await db.insert('recipes', recipe.toMap());
  }

  // --- THESE METHODS ARE NOW INSIDE THE CLASS ---
  Future<List<Map<String, dynamic>>> getAllRecipes() async {
    final db = await database;
    return await db.query('recipes');
  }

  Future<int> updateRecipe(Recipe recipe) async {
    final db = await database;
    return await db.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<int> deleteRecipe(int id) async {
    final db = await database;
    return await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}