
import 'package:t5_1/data/simple_api_status.dart';
import 'package:t5_1/model/status.dart';

class RespositoryStatus{
  ApiStatus api;

  RespositoryStatus(this.api);

  Future<List<Status>> obtenerInformation() async{
    final list = await api.getPostsJson();
    return StatusResponse.fromJson(list).data;
  }

}