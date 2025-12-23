class Information {
  int last_updated;
  int ttl;
  Data data;
  String version;

  Information({
    required this.last_updated,
    required this.ttl,
    required this.data,
    required this.version,
  });

  factory Information.fromJson(Map<String,dynamic> json){
    return Information(
      last_updated: json['last_updated'] as int,
      ttl: json['ttl'] as int,
      data: Data.fromJson(json['data']),
      version: json['version'] as String,
    );
  }
}

class Data {
  List<InformationStation> stations;

  Data({required this.stations});

  factory Data.fromJson(Map<String,dynamic> json){
    return Data(
      stations: (json['stations'] as List<dynamic>).map((e) => InformationStation.fromJson(e as Map<String,dynamic>)).toList(),
    );
  }
} 

class InformationStation{
  String station_id;
  String name;
  String physicial_configuration;
  double lat;
  double lon;
  int altitude;
  String adress;
  String post_code;
  String capacity;
  bool is_charging_station;
  int geofenced_capacity;
  List<String> rental_methods;

  InformationStation({
    required this.station_id,
    required this.name,
    required this.physicial_configuration,
    required this.lat,
    required this.lon,
    required this.altitude,
    required this.adress,
    required this.post_code,
    required this.capacity,
    required this.is_charging_station,
    required this.geofenced_capacity,
    required this.rental_methods,
  });

  factory InformationStation.fromJson(Map<String,dynamic> json){
    return InformationStation(
      station_id: json['station_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      physicial_configuration: json['physical_configuration']?.toString() ?? '',
      lat: (json['lat'] as double),
      lon: (json['lon'] as double),
      altitude: (json['altitude'] as int?) ?? 0,
      adress: json['address']?.toString() ?? '',
      post_code: json['post_code']?.toString() ?? '',
      capacity: json['capacity']?.toString() ?? '',
      is_charging_station: (json['is_charging_station'] as bool?) ?? false,
      geofenced_capacity: (json['geofenced_capacity'] as int?) ?? 0,
      rental_methods: (json['rental_methods'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}