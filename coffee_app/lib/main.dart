import 'package:coffee_app/core/services/injection_container.dart';
import 'package:coffee_app/core/services/router.dart';
import 'package:flutter/material.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
   @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Coffee App',
      onGenerateRoute: generateRoute,
    );
  }
}