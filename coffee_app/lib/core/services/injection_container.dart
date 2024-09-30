
import 'package:coffee_app/data/coffee_local_datasource.dart';
import 'package:coffee_app/data/coffee_repository_impl.dart';
import 'package:coffee_app/domain/repositories/coffee_repository.dart';
import 'package:coffee_app/presentation/coffee_bloc/coffeephoto_bloc.dart';
import 'package:coffee_app/core/services/local_database.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => CoffeePhotoBloc(sl<CoffeeRepository>()));

  // Repository
  sl.registerLazySingleton<CoffeeRepository>(
    () => CoffeeRepositoryImpl(sl<CoffeeLocalDataSource>())
  );

  // Data Source
  sl.registerLazySingleton<CoffeeLocalDataSource>(
    () => CoffeeLocalDataSourceImpl(sl<DatabaseHelper>())
  );

  // Database Helper
  sl.registerLazySingleton(() => DatabaseHelper.instance);
}