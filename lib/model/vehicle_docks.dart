import 'package:t5_1/model/bike_types_enum.dart';

class VehicleDocks {
  Set<BikeTypesEnum> vehicleTypes;
  int count;

  VehicleDocks(this.vehicleTypes, this.count);

  factory VehicleDocks.fromJson(Map<String, dynamic> json) {
    final vehicleTypesList = (json['vehicleTypes'] as List<dynamic>?)
        ?.map((item) => BikeTypesEnum.values.firstWhere(
              (e) => e.name == item?.toString(),
              orElse: () => BikeTypesEnum.UNKNOWN,
            ))
        .toList();

    return VehicleDocks(
      vehicleTypesList != null ? vehicleTypesList.toSet() : {},
      json['count'] ?? 0,
    );
  }
}


