
import 'package:flutter/material.dart';
import 'package:t5_1/data/simple_api_information.dart';
import 'package:t5_1/model/information.dart';

class RepositoryInformation{
  ApiInformation api;

  RepositoryInformation(this.api);

  Future<List<Information>> obtenerInformation() async{

    final list = await api.getPostsJson();
    debugPrint("RESPUESTA CORRECTA");
    for (var e in list){
      e.toString();
    }

    return list.map((e) => Information.fromJson(e as Map<String, dynamic>)).toList();
  }

}