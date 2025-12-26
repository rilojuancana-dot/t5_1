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
  int lastUpdated = 0;

  Status? favStationStatus;
  InformationStation? favStationInformation;

  bool loading = true;
  String? error;

  List<InformationStation> infoData = [];
  List<Status> statusData = [];

  Future<void> getData() async{
      error = null;
      try{
        debugPrint("OBTENIENDO DATOS...");
        var information = await infoRepo.obtenerInformation();
        lastUpdated = information.last_updated;
        infoData = information.data.stations;
        debugPrint("OBTENIENDO DATOS STATUS...");

        statusData = await statusRepo.obtenerInformation();
        favStationStatus = statusData.first;
        favStationInformation = getFavStationInformation();
        
        debugPrint("DATOS OBTENIDOS");
      }catch(e){
        error = e.toString();
        debugPrint("ERROR: $error");
      }
      loading = false;
      debugPrint(loading.toString());

      notifyListeners();
  }
  InformationStation? getFavStationInformation(){
    if(favStationStatus == null) return null;
    return infoData.firstWhere((info) => info.station_id == favStationStatus!.id, orElse: () => throw Exception("Error"));
  }
}