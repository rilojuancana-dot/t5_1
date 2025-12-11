import 'package:t5_1/model/vehicle_docks.dart';
import 'package:t5_1/model/vehicle_types.dart';
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
  VehicleDocks vehicleDocksAvailable;
  List<VehicleTypes> vehicleTypesAvailable;
  
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
    required this.vehicleDocksAvailable,
    required this.vehicleTypesAvailable,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id']?.toString() ?? '',
      bikesAvailable: json['bikesAvailable'] ?? 0,
      bikesDisabled: json['bikesDisabled'] ?? 0,
      status: StatusEnum.values.firstWhere(
        (e) => e.name == json['status']?.toString(),
        orElse: () => StatusEnum.IN_SERVICE,
      ),
      docksAvailable: json['docksAvailable'] ?? 0,
      docksDisabled: json['docksDisabled'] ?? 0,
      lastReported: json['lastReported'] ?? 0,
      isInstalled: json['isInstalled'] ?? false,
      isRenting: json['isRenting'] ?? false,
      isReturning: json['isReturning'] ?? false,
      vehicleDocksAvailable: VehicleDocks.fromJson(
        json['vehicleDocksAvailable'] ?? {},
      ),
      vehicleTypesAvailable: (json['vehicleTypesAvailable'] as List<dynamic>?)
          ?.map((item) => VehicleTypes.fromJson(item))
          .toList() ?? [],
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
        'vehicleDocksAvailable: $vehicleDocksAvailable, '
        'vehicleTypesAvailable: $vehicleTypesAvailable'
        '}';
  }
}

enum StatusEnum {
  IN_SERVICE,
  PLANNED,
}
