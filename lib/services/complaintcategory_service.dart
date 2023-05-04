import 'package:ecom_app/repository/repository.dart';

class ComplaintCategoryService {
  Repository? _repository;
  ComplaintCategoryService(){
    _repository = Repository();
  }

  getComplaintCategories() async {
    return await _repository!.httpGet('complaintCategories');
  }
}