import 'package:ecom_app/models/complaint.dart';
import 'package:ecom_app/models/donation.dart';
import 'package:ecom_app/repository/repository.dart';

class ComplaintService {
  Repository? _repository;

  ComplaintService(){
    _repository = Repository();
  }

  addComplaint(Complaint complaint) async {
    return await _repository!.httpPost('complaints', complaint.toJson());
  }
}