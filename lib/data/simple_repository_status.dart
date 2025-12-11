
import 'package:flutter/material.dart';
import 'package:t5_1/data/simple_api_status.dart';
import 'package:t5_1/model/status.dart';

class RespositoryStatus{
  ApiStatus api;

  RespositoryStatus(this.api);

  Future<List<Status>> obtenerInformation() async{
        debugPrint("PIDIENDO A LA API...");

    final list = await api.getPostsJson();
    return list.map((e) => Status.fromJson(e as Map<String, dynamic>)).toList();
  }

}