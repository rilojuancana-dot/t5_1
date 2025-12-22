import 'package:flutter/material.dart';
import 'package:t5_1/data/simple_repository_information.dart';
import 'package:t5_1/data/simple_repository_status.dart';
import 'package:t5_1/model/information.dart';
import 'package:t5_1/model/status.dart';

class Viewmodel extends ChangeNotifier{
  RepositoryInformation infoRepo;
  RespositoryStatus statusRepo;

  Viewmodel(this.infoRepo, this.statusRepo);

  bool loading = false;
  String? error;

  List<Information> infoData = [];
  List<Status> statusData = [];

  Future<void> getData() async{
      loading = true;
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

      notifyListeners();
  }
}