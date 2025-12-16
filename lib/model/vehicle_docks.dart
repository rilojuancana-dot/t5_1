import 'package:t5_1/model/bike_types_enum.dart';

class VehicleDocks {
  Set<BikeTypesEnum> vehicleTypes;
  int count;

  VehicleDocks(this.vehicleTypes, this.count);

  factory VehicleDocks.fromJson(Map<String, dynamic> json) {
    final vehicleTypesList = (json['vehicle_type_ids'] as List<dynamic>?)
        ?.map((item) {
          final typeString = item.toString().toUpperCase();
          return BikeTypesEnum.values.firstWhere(
            (e) => e.name == typeString,
            orElse: () => BikeTypesEnum.UNKNOWN,
          );
        })
        .toList();

    return VehicleDocks(
      vehicleTypesList != null ? vehicleTypesList.toSet() : {},
      (json['count'] as int?) ?? 0,
    );
  }

  @override
  String toString() {
    return 'VehicleDocks{vehicleTypes: ${vehicleTypes.map((e) => e.name).toList()}, count: $count}';
  }
}


