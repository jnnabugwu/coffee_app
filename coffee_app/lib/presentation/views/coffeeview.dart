import 'package:coffee_app/presentation/coffee_bloc/coffeephoto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeDisplay extends StatefulWidget {
  const CoffeeDisplay({Key? key}) : super(key: key);
  static const routeName = '/coffee-display';

  @override
  _CoffeeDisplayState createState() => _CoffeeDisplayState();
}

class _CoffeeDisplayState extends State<CoffeeDisplay> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event once when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CoffeePhotoBloc>().add(const GetCoffeePhotoEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Display'),
      ),
      body: BlocConsumer<CoffeePhotoBloc, CoffeePhotoState>(
        listener: (context, state) {
          if (state is CoffeePhotoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CoffeePhotoInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CoffeePhotoLoaded) {
            return Center(
              child: Image.network(
                state.coffeePhoto.file,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / 
                            loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Failed to load image'));
                },
              ),
            );
          } else if (state is CoffeePhotoError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CoffeePhotoBloc>().add(const GetCoffeePhotoEvent());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
