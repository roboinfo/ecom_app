import 'package:ecom_app/models/donation.dart';
import 'package:ecom_app/repository/repository.dart';

class DonationService {
  Repository? _repository;

  DonationService(){
    _repository = Repository();
  }

  addDonation(Donation donation) async {
    return await _repository!.httpPost('donation', donation.toJson());
  }
}