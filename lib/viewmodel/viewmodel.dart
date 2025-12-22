import 'package:flutter/material.dart';
import 'package:t5_1/data/simple_api_information.dart';
import 'package:t5_1/data/simple_api_status.dart';
import 'package:t5_1/data/simple_repository_information.dart';
import 'package:t5_1/data/simple_repository_status.dart';
import 'package:t5_1/model/information.dart';
import 'package:t5_1/model/status.dart';

class Viewmodel extends ChangeNotifier{
  RepositoryInformation infoRepo = RepositoryInformation(ApiInformation());
  RespositoryStatus statusRepo = RespositoryStatus(ApiStatus());

  

  bool loading = true;
  String? error;

  List<Information> infoData = [];
  List<Status> statusData = [];

  Future<void> getData() async{
      debugPrint(loading.toString());
      error = null;
      notifyListeners();

      try{
        debugPrint("OBTENIENDO DATOS...");
        //infoData = await infoRepo.obtenerInformation();
        statusData = await statusRepo.obtenerInformation();
        debugPrint("DATOS OBTENIDOS");
      }catch(e){
        error = e.toString();
        debugPrint("ERROR: $error");
      }
      loading = false;
      debugPrint(loading.toString());

      notifyListeners();
  }
}