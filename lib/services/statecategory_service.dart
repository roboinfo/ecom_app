import 'package:ecom_app/repository/repository.dart';

class StateCategoryService {
  Repository? _repository;
  StateCategoryService(){
    _repository = Repository();
  }

  getStateCategories() async {
    return await _repository!.httpGet('stateCategories');
  }
}