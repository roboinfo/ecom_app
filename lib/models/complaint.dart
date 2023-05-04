class Complaint {
  int? id;
  String? blockcategory;
  String? complaintcategory;
  String? description;
  String? adress;


  toJson(){
    return {
      'id' : id.toString(),
      'blockcategory' : blockcategory.toString(),
      'complaintcategory' : complaintcategory.toString(),
      'description' : description,
      'adress' : adress,

    };
  }
}