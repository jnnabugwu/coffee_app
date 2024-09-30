import 'dart:convert';

import 'package:coffee_app/core/services/local_database.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:http/http.dart' as http;
import 'package:coffee_app/core/config/api_config.dart';

abstract class CoffeeLocalDataSource {
  Future<CoffeeModel> getCoffee();
  Future<bool> saveCoffeeImage(CoffeeModel coffeeImage);
  Future<List<CoffeeModel>> getAllCoffeeImages();
}

class CoffeeLocalDataSourceImpl implements CoffeeLocalDataSource {
  final DatabaseHelper _databaseHelper;

  CoffeeLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<CoffeeModel> getCoffee() async {
    final httpResponse = await http.get(Uri.parse(ApiConfig.randomCoffeeEndpoint));
    if (httpResponse.statusCode == 200) {
      final jsonData = json.decode(httpResponse.body);
       return CoffeeModel.fromJson(jsonData);
      
    } else {
      throw Exception('Failed to load coffee data');
    }
  }

   @override
     Future<List<CoffeeModel>> getAllCoffeeImages() async {
    return await _databaseHelper.getCoffeeImages();
  }

  @override
      Future<bool> saveCoffeeImage(CoffeeModel coffeeImage) async {
    final id = await _databaseHelper.insertCoffeeImage(coffeeImage);
    return id != 0;
  }


}