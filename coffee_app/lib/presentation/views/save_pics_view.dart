import 'dart:io';

import 'package:coffee_app/presentation/coffee_bloc/coffeephoto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_app/models/coffee.dart';

class SavedCoffeePicturesView extends StatelessWidget {
  static const routeName = '/saved-pictures-display';

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Coffee Pictures'),
      ),
      body: BlocBuilder<CoffeePhotoBloc, CoffeePhotoState>(
        builder: (context, state) {
          if (state is CoffeePhotoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CoffeeSavedPhotos) {
            return _buildPhotoGrid(state.savedPhotos);
          } else if (state is CoffeePhotoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No saved photos'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CoffeePhotoBloc>().add(GetSavedPhotos());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildPhotoGrid(List<CoffeeModel> photos) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return _buildPhotoItem(photos[index]);
      },
    );
  }

  Widget _buildPhotoItem(CoffeeModel coffee) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.file(
              File(coffee.file),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'ID: ${coffee.id}',
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}