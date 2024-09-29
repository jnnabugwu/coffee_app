import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:coffee_app/data/coffee_remote_datasource.dart';
import 'package:coffee_app/models/coffee.dart';

part 'coffeephoto_event.dart';
part 'coffeephoto_state.dart';

class CoffeePhotoBloc extends Bloc<CoffeePhotoEvent, CoffeePhotoState> {

  final CoffeeRemoteDataSource _dataSource;


  CoffeePhotoBloc(this._dataSource) : super(const CoffeePhotoInitial()) {
    on<GetCoffeePhotoEvent>((event, emit) async {
      try{
        emit(const CoffeePhotoLoading());
       var coffee = await _dataSource.getCoffee();
        emit(CoffeePhotoLoaded(coffee));
      } catch (e) {
        emit(CoffeePhotoError(e.toString()));
      }
    });
  }
}
