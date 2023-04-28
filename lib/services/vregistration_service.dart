import 'package:ecom_app/models/vregistration.dart';
import 'package:ecom_app/repository/repository.dart';

class RegistrationService {
  Repository? _repository;

  RegistrationService(){
    _repository = Repository();
  }

  addRegistration(Registration registration) async {
    return await _repository!.httpPost('registration', registration.toJson());
  }
}