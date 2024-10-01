import 'package:coffee_app/core/services/injection_container.dart';
import 'package:coffee_app/presentation/coffee_bloc/coffeephoto_bloc.dart';
import 'package:coffee_app/presentation/views/coffeeview.dart';
import 'package:coffee_app/presentation/views/save_pics_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  
  switch (settings.name){
    case CoffeeDisplay.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(create: (_) => sl<CoffeePhotoBloc>(), child: const CoffeeDisplay()));
    
    
    case SavedCoffeePicturesView.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(create: (_) => sl<CoffeePhotoBloc>(), child: SavedCoffeePicturesView()));
    

    default:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(create: (_) => sl<CoffeePhotoBloc>(), child: const CoffeeDisplay()));
  }
}