class Registration {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? date;
  String? statecategory;
  String? adress;
  String? pin;
  String? skillcategory;

  toJson(){
    return {
      'id' : id.toString(),
      'name' : name.toString(),
      'mobile' : mobile,
      'email' : email,
      'date' : date,
      'statecategory' : statecategory.toString(),
      'adress' : adress,
      'pin' : pin,
      'skillcategory' : skillcategory.toString(),
    };
  }
}