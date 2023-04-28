class Shipping {
  int? id;
  String? name;
  String? email;
  String? adress;

  toJson(){
    return {
      'id' : id.toString(),
      'name' : name.toString(),
      'email' : email,
      'address' : adress
    };
  }
}