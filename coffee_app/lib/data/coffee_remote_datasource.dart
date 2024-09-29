import 'dart:convert';

import 'package:coffee_app/models/coffee.dart';
import 'package:http/http.dart' as http;
import 'package:coffee_app/core/config/api_config.dart';

abstract class CoffeeRemoteDataSource {
  Future<CoffeeModel> getCoffee();
}

class CoffeeRemoteDataSourceImpl implements CoffeeRemoteDataSource {
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
}