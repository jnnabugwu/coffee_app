import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_app/domain/repositories/coffee_repository.dart';
import 'package:coffee_app/models/savedcoffee.dart'; 
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:coffee_app/models/coffee.dart';

part 'coffeephoto_event.dart';
part 'coffeephoto_state.dart';

class CoffeePhotoBloc extends Bloc<CoffeePhotoEvent, CoffeePhotoState> {
  final CoffeeRepository _coffeeRepository;  

  CoffeePhotoBloc(this._coffeeRepository) : super(const CoffeePhotoInitial()) {
    on<GetCoffeePhotoEvent>(_getCoffeePhoto);
    on<SaveFavorite>(_savePhoto);
    on<GetSavedPhotos>(_getAllSavedPhotos);
  }

  Future<void> _getCoffeePhoto(GetCoffeePhotoEvent event, Emitter<CoffeePhotoState> emit) async {
    try {
      emit(const CoffeePhotoLoading());
      var coffee = await _coffeeRepository.getCoffee();  
      emit(CoffeePhotoLoaded(coffee!));
    } catch (e) {
      emit(CoffeePhotoError(e.toString()));
    }
  }

  Future<void> _savePhoto(SaveFavorite event, Emitter<CoffeePhotoState> emit) async {
    try {
      emit(const CoffeePhotoSaving());  
      bool saved = await _coffeeRepository.saveCoffeeImage(event.coffee.file);  
      if (saved) {
        emit(const CoffeePhotoSaveSuccess());
        Future.delayed(const Duration(seconds: 2));
        var coffee = await _coffeeRepository.getCoffee();
        emit(CoffeePhotoLoaded(coffee!));
      } else {
        emit(const CoffeePhotoError("Failed to save photo"));
      }
    } catch (e) {
      emit(CoffeePhotoError("Didn't save photo: ${e.toString()}"));
    }
  }

  Future<void> _getAllSavedPhotos(GetSavedPhotos event,Emitter<CoffeePhotoState> emit) async {
      try {
        emit(const CoffeePhotoSaving());
        var savedPhotos = await _coffeeRepository.getAllCoffeeImages();
        emit(CoffeeSavedPhotos(savedPhotos));
      } catch (e) {
        emit(const CoffeePhotoError('Couldnt bring in saved photos'));
      }
  }

}