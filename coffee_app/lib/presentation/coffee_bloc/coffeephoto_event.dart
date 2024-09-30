part of 'coffeephoto_bloc.dart';

@immutable
abstract class CoffeePhotoEvent extends Equatable{

  const CoffeePhotoEvent();

  @override
  List<Object?> get props => [];  
}

///we need an event to trigger getting the coffee photo
class GetCoffeePhotoEvent extends CoffeePhotoEvent{
  const GetCoffeePhotoEvent();
 
}
///what do i need: the coffee class
class SaveFavorite extends CoffeePhotoEvent{
  final CoffeeModel coffee;
  const SaveFavorite(this.coffee);
}