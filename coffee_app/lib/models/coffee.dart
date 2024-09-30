


class CoffeeModel{
  final String file;
  final int? id;
  final String imgHash;
  
  CoffeeModel({
    required this.file,
   this.id,
    required this.imgHash
  });
  
  CoffeeModel.fromJson(Map<String,dynamic> json) : 
  file = json['file'] as String,
  id = 0,
  imgHash = "";

  Map<String, dynamic> toJson() {
    return {
      'file': file,
      'id': id,
      'imgHash': imgHash
    };
  }
}
/// Im thinking this is going to be the photo 
/// add something to hold favorites 
