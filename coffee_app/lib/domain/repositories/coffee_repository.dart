
import 'package:coffee_app/models/coffee.dart';

abstract class CoffeeRepository {
  ///So i need to save coffee locally
  ///get all coffee
  ///delete coffee
  Future<List<CoffeeModel>> getAllCoffeeImages();
  Future<bool> saveCoffeeImage(String imageUrl);
  Future<CoffeeModel?> getCoffee();
}