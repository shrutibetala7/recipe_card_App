import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/models/recipe_database.dart';

class DatabaseHelper {
  //singleton object
  static DatabaseHelper _dbHelper;
  static Database _db;

  //columns for the database
  String dbTable = 'recipe_table';
  String colId = 'id';
  String colTitle = 'title';
  String colCuisine = 'cuisine';
  String colIngredients = 'ingredients';
  String colRecipe = 'recipe';
  String colDate = 'date';
  String colCalories = 'calories';

  //Named constructor to create instance of the database
  DatabaseHelper._createInstance();

  //factory constructor
  factory DatabaseHelper() {
    if (_dbHelper == null) {
      _dbHelper = DatabaseHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    // lazily instantiate the db the first time it is accessed
    if (_db == null) _db = await initializeDatabase();
    return _db;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'recipe.db';

    // Open/create the database at a given path
    var recipeDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return recipeDatabase;
  }

// Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

//create the database
  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $dbTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colCuisine TEXT, $colIngredients TEXT, $colRecipe TEXT, $colDate TEXT, $colCalories INTEGER)');
  }

// All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.

  Future<List<Map<String, dynamic>>> getRecipeMapList() async {
    Database db = await this.database;
//check by commenting above line and instead writing _db
//var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(dbTable, orderBy: '$colTitle ASC');
    return result;
  }

// Insert Operation: Insert a recipe
  Future<int> insertRecipe(Recipe_info recipe) async {
    Database db = await this.database;
    var result = await db.insert(dbTable, recipe.toMap());
    return result;
  }

// Update Operation: Update a recipe
  Future<int> updateRecipe(Recipe_info recipe) async {
    Database db = await this.database;
    var result = await db.update(dbTable, recipe.toMap(),
        where: '$colId=?', whereArgs: [recipe.id]);
    return result;
  }

// Delete Operation: Delete a recipe
  Future<int> deleteRecipe(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $dbTable WHERE $colId = $id');
    return result;
  }

// Get number of Recipes
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $dbTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

//As we will obtain map , it has to be converted back
// Get the 'Map List' [ List<Map> ] and convert it to 'Recipe List' [ List<Recipe> ]
  Future<List<Recipe_info>> getRecipeList() async {
    var RecipeMapList =
        await getRecipeMapList(); // Get 'Map List' from database
    int count =
        RecipeMapList.length; // Count the number of map entries in db table

    List<Recipe_info> RecipeList = List<Recipe_info>();
    // For loop to create a 'Recipe List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      RecipeList.add(Recipe_info.fromMapObject(RecipeMapList[i]));
    }

    return RecipeList;
  }
}
