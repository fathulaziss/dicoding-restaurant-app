import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  DatabaseHelper._internal() {
    _instance = this;
  }

  static DatabaseHelper? _instance;
  static Database? _database;
  static const String _tblFavorites = 'favorites';

  Future<Database> _initializeDb() async {
    final path = await getDatabasesPath();
    final db = openDatabase(
      '$path/restaurantapp.db',
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $_tblFavorites (id TEXT PRIMARY KEY,name TEXT,description TEXT,pictureId TEXT,city TEXT,categories TEXT,menus TEXT,rating REAL,customerReviews TEXT)',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    return _database ??= await _initializeDb();
  }

  Future<List<RestaurantModel>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblFavorites);

    return List.from(results.map(RestaurantModel.fromMapDatabase));
  }

  Future<void> insertFavorites(RestaurantModel restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorites, restaurant.toMapDatabase());
  }

  Future<void> removeFavorites(String id) async {
    final db = await database;

    await db!.delete(_tblFavorites, where: 'id = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>> getFavoriteById(String id) async {
    final db = await database;

    final List<Map<String, dynamic>> results =
        await db!.query(_tblFavorites, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }
}
