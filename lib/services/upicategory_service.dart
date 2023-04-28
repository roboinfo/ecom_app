import 'package:ecom_app/repository/repository.dart';

class UpiCategoryService {
  Repository? _repository;
  UpiCategoryService(){
    _repository = Repository();
  }

  getUpiCategories() async {
    return await _repository!.httpGet('upiCategories');
  }
}