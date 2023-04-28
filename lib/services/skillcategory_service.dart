import 'package:ecom_app/repository/repository.dart';

class SkillCategoryService {
  Repository? _repository;
  SkillCategoryService(){
    _repository = Repository();
  }

  getSkillCategories() async {
    return await _repository!.httpGet('skillCategories');
  }
}