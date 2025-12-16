import 'package:t5_1/model/bike_types_enum.dart';

class VehicleTypes {
  BikeTypesEnum bikeType;
  int count;

  VehicleTypes(this.bikeType, this.count);

  factory VehicleTypes.fromJson(Map<String, dynamic> json) {
    final typeString = (json['vehicle_type_id'] as String?)?.toUpperCase() ?? '';
    
    return VehicleTypes(
      BikeTypesEnum.values.firstWhere(
        (e) => e.name == typeString,
        orElse: () => BikeTypesEnum.UNKNOWN,
      ),
      (json['count'] as int?) ?? 0,
    );
  }

  @override
  String toString() {
    return 'VehicleTypes{bikeType: ${bikeType.name}, count: $count}';
  }
}
