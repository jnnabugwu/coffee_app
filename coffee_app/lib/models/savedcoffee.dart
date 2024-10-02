class SavedCoffeeModel{
  final String file;
  final int? id;
  final String? imgHash;
  
  SavedCoffeeModel({
    required this.file,
   this.id,
   this.imgHash
  });
  
  SavedCoffeeModel.fromJson(Map<String,dynamic> json) : 
  file = json['file'] as String,
  id = json['id'] as int,
  imgHash = json['imgHash'] as String;

  Map<String, dynamic> toJson() {
    return {
      'file': file,
      'id': id,
      'imgHash': imgHash
    };
  }
}