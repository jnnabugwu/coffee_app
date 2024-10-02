import 'dart:convert';

import 'package:coffee_app/core/services/local_database.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/models/savedcoffee.dart';
import 'package:http/http.dart' as http;
import 'package:coffee_app/core/config/api_config.dart';

abstract class CoffeeDataSource {
  Future<CoffeeModel?> getCoffee();
  Future<bool> saveCoffeeImage(SavedCoffeeModel coffeeImage);
  Future<List<SavedCoffeeModel>> getAllCoffeeImages();
}

class CoffeeDataSourceImpl implements CoffeeDataSource {
  final DatabaseHelper _databaseHelper;
  final http.Client _httpClient;

  CoffeeDataSourceImpl(this._databaseHelper, {http.Client? httpClient}) :
    _httpClient = httpClient ?? http.Client();

  @override
@override
Future<CoffeeModel?> getCoffee() async {
  final response = await _httpClient.get(Uri.parse(ApiConfig.randomCoffeeEndpoint));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    if (jsonData is Map<String, dynamic> && jsonData['file'] is String) {
      
      return CoffeeModel.fromJson(jsonData);
    } else {
      return null;
    }
  } else {
    throw Exception('Failed to load coffee data: ${response.statusCode}');
  }
}

   @override
     Future<List<SavedCoffeeModel>> getAllCoffeeImages() async {
    return await _databaseHelper.getCoffeeImages();
  }

  @override
      Future<bool> saveCoffeeImage(SavedCoffeeModel coffeeImage) async {
    final id = await _databaseHelper.insertCoffeeImage(coffeeImage);
    return id != 0;
  }


}