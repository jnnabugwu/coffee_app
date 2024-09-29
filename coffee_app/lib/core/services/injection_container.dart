
import 'package:coffee_app/data/coffee_remote_datasource.dart';
import 'package:coffee_app/presentation/coffee_bloc/coffeephoto_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initBloc();
}

Future<void> _initBloc() async {
  sl..
  registerFactory(
      () => CoffeePhotoBloc(sl()),)
   ..registerLazySingleton<CoffeeRemoteDataSource>(() => CoffeeRemoteDataSourceImpl())   
      ;
}