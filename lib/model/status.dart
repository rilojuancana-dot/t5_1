//import 'package:t5_1/model/vehicle_docks.dart';
//import 'package:t5_1/model/vehicle_types.dart';

class StatusResponse {
  final int lastUpdated;
  final int ttl;
  final Stations data;
  final String version;

  StatusResponse({
    required this.lastUpdated,
    required this.ttl,
    required this.data,
    required this.version,
  });

  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    return StatusResponse(
      lastUpdated: json['last_updated'] as int,
      ttl: json['ttl'] as int,
      data: Stations.fromJson(json['data']),
      version: json['version'] as String,
    );
  }
}
class Stations{
  List<Status> status;

  Stations({required this.status});

  factory Stations.fromJson(Map<String,dynamic> json) {
    return Stations(
      status: (json['stations'] as List<dynamic>).map((e) => Status.fromJson(e)).toList()
    );
  }
}

class Status {
  String id;
  int bikesAvailable;
  int bikesDisabled;
  StatusEnum status;
  int docksAvailable;
  int docksDisabled; 
  int lastReported; 
  bool isInstalled;
  bool isRenting;
  bool isReturning;
  //VehicleDocks vehicleDocksAvailable;
  //List<VehicleTypes> vehicleTypesAvailable;
  
  Status({
    required this.id,
    required this.bikesAvailable,
    required this.bikesDisabled,
    required this.status,
    required this.docksAvailable,
    required this.docksDisabled,
    required this.lastReported,
    required this.isInstalled,
    required this.isRenting,
    required this.isReturning,
    //required this.vehicleDocksAvailable,
    //required this.vehicleTypesAvailable,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['station_id']?.toString() ?? '',
      bikesAvailable: json['num_bikes_available'] ?? 0,
      bikesDisabled: json['num_bikes_disabled'] ?? 0,
      status: StatusEnum.values.firstWhere(
        (e) => e.name == json['status']?.toString(),
        orElse: () => StatusEnum.IN_SERVICE,
      ),
      docksAvailable: json['num_docks_available'] ?? 0,
      docksDisabled: json['num_docks_disabled'] ?? 0,
      lastReported: json['last_reported'] ?? 0,
      isInstalled: json['is_installed'] ?? false,
      isRenting: json['is_renting'] ?? false,
      isReturning: json['is_returning'] ?? false,/*
      vehicleDocksAvailable: VehicleDocks.fromJson(
        json['vehicle_docks_available'] ?? {},
      ),
      vehicleTypesAvailable: (json['vehicle_types_available'] as List<dynamic>?)
          ?.map((item) => VehicleTypes.fromJson(item))
          .toList() ?? [],*/
    );
  }
  @override
  String toString() {
    return 'Status{'
        'id: $id, '
        'bikesAvailable: $bikesAvailable, '
        'bikesDisabled: $bikesDisabled, '
        'status: ${status.name}, '
        'docksAvailable: $docksAvailable, '
        'docksDisabled: $docksDisabled, '
        'lastReported: $lastReported, '
        'isInstalled: $isInstalled, '
        'isRenting: $isRenting, '
        'isReturning: $isReturning, '
        //'vehicleDocksAvailable: $vehicleDocksAvailable, '
        //'vehicleTypesAvailable: $vehicleTypesAvailable'
        '}';
  }
}

enum StatusEnum {
  IN_SERVICE,
  PLANNED,
}
