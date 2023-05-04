import 'package:ecom_app/repository/repository.dart';

class BlockCategoryService {
  Repository? _repository;
  BlockCategoryService(){
    _repository = Repository();
  }

  getBlockCategories() async {
    return await _repository!.httpGet('blockCategories');
  }
}