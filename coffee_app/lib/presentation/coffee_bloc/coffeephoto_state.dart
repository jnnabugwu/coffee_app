part of 'coffeephoto_bloc.dart';

@immutable
abstract class CoffeePhotoState extends Equatable {
  const CoffeePhotoState();
  @override
  List<Object> get props => [];
}

class CoffeePhotoInitial extends CoffeePhotoState {
      const CoffeePhotoInitial();
}

class CoffeePhotoLoading extends CoffeePhotoState {
  const CoffeePhotoLoading();
}

class CoffeePhotoLoaded extends CoffeePhotoState{
  const CoffeePhotoLoaded(this.coffeePhoto);
  final CoffeeModel coffeePhoto;
  @override
  List<Object> get props => [coffeePhoto];
}

class CoffeePhotoError extends CoffeePhotoState{
  const CoffeePhotoError(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}