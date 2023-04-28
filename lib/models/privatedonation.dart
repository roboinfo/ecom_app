class PrivateDonation {
  int? id;
  String? amount;
  String? cause;
  String? upicategory;
  String? referral;

  toJson(){
    return {
      'id' : id.toString(),
      'amount' : amount.toString(),
      'cause' : cause,
      'upicategory': upicategory.toString(),
      'referral' : referral
    };
  }
}