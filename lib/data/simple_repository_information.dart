
import 'package:t5_1/data/simple_api_information.dart';
import 'package:t5_1/model/information.dart';

class RepositoryInformation{
  ApiInformation api;

  RepositoryInformation(this.api);

  Future<Information> obtenerInformation() async{

    final list = await api.getPostsJson();
    return Information.fromJson(list);

  }

}