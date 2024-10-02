import 'dart:io';

import 'package:coffee_app/models/savedcoffee.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('coffee_images.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE coffee_images(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file TEXT,
        imgHash TEXT UNIQUE
      )
    ''');
  }

  Future<String> computeImageHash(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> isImageDuplicate(String imageHash) async {
    final db = await database;
    final result = await db.query(
      'coffee_images',
      where: 'imageHash = ?',
      whereArgs: [imageHash],
    );
    return result.isNotEmpty;
  }

  Future<int> insertCoffeeImage(SavedCoffeeModel coffeeImage) async {
    final db = await database;
    var map = coffeeImage.toJson();
    map.remove('id');
    return await db.insert('coffee_images', map);
  }

  Future<void> saveImage(String name, String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = join(directory.path, '$name.jpg');
  
  File imageFile = File(imagePath);
  await imageFile.writeAsBytes(response.bodyBytes);

  final imageHash = await DatabaseHelper.instance.computeImageHash(imageFile);
  final isDuplicate = await DatabaseHelper.instance.isImageDuplicate(imageHash);

  if (!isDuplicate) {
    final coffeeImage = SavedCoffeeModel(
      file: imagePath,
      imgHash: imageHash,
    );

    await DatabaseHelper.instance.insertCoffeeImage(coffeeImage);
    print('New image saved: $name');
  } else {
    // Delete the file we just saved as it's a duplicate
    await imageFile.delete();
    print('Duplicate image not saved: $name');
    throw('Duplicate image not saved: $name');
  }
}

  Future<List<SavedCoffeeModel>> getCoffeeImages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('coffee_images');
    print('making list');
    return List.generate(maps.length, (i) {
      return SavedCoffeeModel(
        id: maps[i]['id'],
        file: maps[i]['file'],
        imgHash: maps[i]['imgHash'],
      );
    });
  }
}