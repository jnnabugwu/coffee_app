import 'package:equatable/equatable.dart';


class CoffeeModel extends Equatable {
  final String file;
  
  
  const CoffeeModel({
    required this.file,
  });
  
  CoffeeModel.fromJson(Map<String,dynamic> json) : 
  file = json['file'] as String;

  Map<String, dynamic> toJson() {
    return {
      'file': file
    };
  }
  
  @override
  List<Object?> get props => [file];

}
/// Im thinking this is going to be the photo 
/// add something to hold favorites 
