import 'package:ecom_app/repository/repository.dart';

class ProductCategoryService {
  Repository? _repository;
  ProductCategoryService(){
    _repository = Repository();
  }

  getProductCategories() async {
    return await _repository!.httpGet('productCategories');
  }
}