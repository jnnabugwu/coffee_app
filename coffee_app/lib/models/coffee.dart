class CoffeeModel{
  final String file;
  
  CoffeeModel({
    required this.file,
  });
  
  CoffeeModel.fromJson(Map<String,dynamic> json) : 
  file = json['file'] as String;

  Map<String, dynamic> toJson() {
    return {
      'file': file,
    };
  }
}

