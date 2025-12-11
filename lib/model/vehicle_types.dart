import 'package:t5_1/model/bike_types_enum.dart';

class VehicleTypes {
  BikeTypesEnum bikeType;
  int count;

  VehicleTypes(this.bikeType, this.count);

  factory VehicleTypes.fromJson(Map<String, dynamic> json) {
    return VehicleTypes(
      BikeTypesEnum.values.firstWhere(
        (e) => e.name == json['bikeType']?.toString(),
        orElse: () => BikeTypesEnum.UNKNOWN,
      ),
      json['count'] ?? 0,
    );
  }
}
