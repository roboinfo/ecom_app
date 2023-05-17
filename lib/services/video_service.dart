import 'package:ecom_app/repository/repository.dart';

class VideoService {
  Repository? _repository;
  VideoService(){
    _repository = Repository();
  }

  getVideos() async {
    return await _repository!.httpGet('videos');
  }
}