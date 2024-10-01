import 'dart:io';

import 'package:coffee_app/data/coffee_local_datasource.dart';
import 'package:coffee_app/domain/repositories/coffee_repository.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path; 

class CoffeeRepositoryImpl implements CoffeeRepository{
  final CoffeeLocalDataSource _localDataSource;

  CoffeeRepositoryImpl(this._localDataSource);

  @override
  Future<List<CoffeeModel>> getAllCoffeeImages() {
    try {
      return _localDataSource.getAllCoffeeImages();
    } catch (e) {
      throw 'Something went wrong $e';
    }
  }

  @override
  Future<CoffeeModel?> getCoffee() {
    try {
     return _localDataSource.getCoffee();
    } catch (e) {
      print('Something went wrong $e');
      throw 'Something went wrong $e';
    }
  }

  @override
  Future<bool> saveCoffeeImage(String imageUrl) async {
    try{
      final response = await http.get(Uri.parse(imageUrl));
      final directory = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = path.join(directory.path, fileName);

      File imageFile = File(filePath);
      await imageFile.writeAsBytes(response.bodyBytes);
      String imageHash = await computeImageHash(imageFile);

      final coffeeImage = CoffeeModel(
        file: filePath,
        imgHash: imageHash, 
      );  
    return await _localDataSource.saveCoffeeImage(coffeeImage);
    } catch (e) {
      print( 'Error inserting coffee image: $e');
      return false;
    }

  }

  Future<String> computeImageHash(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
}