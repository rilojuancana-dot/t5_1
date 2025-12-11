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
      error = null;
      notifyListeners();
      
      try{
        infoData = await infoRepo.obtenerInformation();
        statusData = await statusRepo.obtenerInformation();
      }catch(e){
        error = e.toString(); 
        infoData = [];
        statusData = [];
      }

      loading = false;
      notifyListeners();
  }
}