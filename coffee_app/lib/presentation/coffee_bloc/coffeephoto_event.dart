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