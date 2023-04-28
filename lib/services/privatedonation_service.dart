import 'package:ecom_app/repository/repository.dart';

import '../models/privatedonation.dart';

class PrivateDonationService {
  Repository? _repository;

  PrivateDonationService(){
    _repository = Repository();
  }

  addPrivateDonation(PrivateDonation privatedonation) async {
    return await _repository!.httpPost('private-donation', privatedonation.toJson());
  }
}