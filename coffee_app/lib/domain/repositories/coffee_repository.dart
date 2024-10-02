
import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/models/savedcoffee.dart';

abstract class CoffeeRepository {
  ///So i need to save coffee locally
  ///get all coffee
  ///delete coffee
  Future<List<SavedCoffeeModel>> getAllCoffeeImages();
  Future<bool> saveCoffeeImage(String imageUrl);
  Future<CoffeeModel?> getCoffee();
}