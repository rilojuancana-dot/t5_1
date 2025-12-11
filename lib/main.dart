import 'package:flutter/material.dart';
import 'package:t5_1/data/simple_api_information.dart';
import 'package:t5_1/data/simple_api_status.dart';
import 'package:t5_1/data/simple_repository_information.dart';
import 'package:t5_1/data/simple_repository_status.dart';
import 'package:t5_1/viewmodel/viewmodel.dart';

void main() async{
  debugPrint("hola");
  ApiInformation apiInfo = ApiInformation();
  ApiStatus apiStatus = ApiStatus();
  RepositoryInformation infoRepo = RepositoryInformation(apiInfo);
  RespositoryStatus statusRepo = RespositoryStatus(apiStatus);
  Viewmodel viewmodel = Viewmodel(infoRepo, statusRepo);

  viewmodel.getData();
  while(viewmodel.loading) {
    debugPrint("Cargando...");
    await Future.delayed(Duration(seconds: 2));
  }
  for (var status in viewmodel.statusData){
    debugPrint(status.toString());
  }
}

