class Donation {
  int? id;
  String? amount;
  String? name;
  String? mobile;
  String? email;
  String? statecategory;
  String? adress;
  String? cause;
  String? referral;

  toJson(){
    return {
      'id' : id.toString(),
      'amount' : amount.toString(),
      'name' : name.toString(),
      'mobile' : mobile,
      'email' : email,
      'statecategory' : statecategory.toString(),
      'adress' : adress,
      'cause' : cause,
      'referral' : referral,
    };
  }
}