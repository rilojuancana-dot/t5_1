import 'package:flutter_test/flutter_test.dart';
import 'package:t5_1/model/bike_types_enum.dart';
import 'package:t5_1/model/information.dart';
import 'package:t5_1/model/status.dart';
import 'package:t5_1/model/vehicle_types.dart';

void main() {
  group('Capa de modelo', () {
    
    test('Information.fromJson crea una instancia correctamente', () {
      final json = {
        'last_updated': 1625247600,
        'ttl': 300,
        'data': {
          'stations': [
            {
              'station_id': '123',
              'name': 'Station 1',
              'physical_configuration': 'KIOSK',
              'lat': 40.7128,
              'lon': -74.0060,
              'altitude': 10,
              'adress': '123 Main St',
              'post_code': '10001',
              'capacity': '15',
              'is_charging_station': true,
              'geofenced_capacity': 5,
              'rental_methods': ['KEY', 'APP'],
            },
          ],
        },
        'version': '2.0',
      };

      final information = Information.fromJson(json);

      expect(information.last_updated, 1625247600);
      expect(information.ttl, 300);
      expect(information.version, '2.0');
      expect(information.data.stations.length, 1);
      expect(information.data.stations[0].station_id, '123');
    });
    test('Information.fromJson maneja valores faltantes', () {
      final json = {
        'last_updated': null,
        'ttl': null,
        'data': {
          'stations': null,
        },
        'version': null,
      };

      final information = Information.fromJson(json);

      expect(information.last_updated, 0);
      expect(information.ttl, 0);
      expect(information.version, '');
      expect(information.data.stations.length, 0);
    });
  });

  test('Status.fromJson crea una instancia correctamente', () {
    final json = {
      'station_id': '123',
      'num_bikes_available': 10,
      'num_bikes_disabled': 2,
      'status': 'IN_SERVICE',
      'num_docks_available': 5,
      'num_docks_disabled': 1,
      'last_reported': 1625247600,
      'is_installed': true,
      'is_renting': true,
      'is_returning': false,
      'vehicle_types_available': [
        {'vehicle_type_id': 'BOOST'},
        {'vehicle_type_id': 'EFIT'},
        {'vehicle_type_id': 'FIT'},
        {'vehicle_type_id': 'UNKNOWN'},
      ],
    };

    final status = Status.fromJson(json);


    expect(status.id, '123');
    expect(status.bikesAvailable, 10);
    expect(status.bikesDisabled, 2);
    expect(status.status, StatusEnum.IN_SERVICE);
    expect(status.docksAvailable, 5);
    expect(status.docksDisabled, 1);
    expect(status.lastReported, 1625247600);
    expect(status.isInstalled, true);
    expect(status.isRenting, true);
    expect(status.isReturning, false);
    expect(status.vehicleTypesAvailable.length, 4);
    expect(status.vehicleTypesAvailable[0].bikeType, BikeTypesEnum.BOOST);
    expect(status.vehicleTypesAvailable[1].bikeType, BikeTypesEnum.EFIT);
    expect(status.vehicleTypesAvailable[2].bikeType, BikeTypesEnum.FIT);
    expect(status.vehicleTypesAvailable[3].bikeType, BikeTypesEnum.UNKNOWN);
  });
  test('Status.fromJson maneja valores faltantes', () {
    final json = {
      'station_id': null,
      'num_bikes_available': null,
      'num_bikes_disabled': null,
      'status': null,
      'num_docks_available': null,
      'num_docks_disabled': null,
      'last_reported': null,
      'is_installed': null,
      'is_renting': null,
      'is_returning': null,
      'vehicle_types_available': [],
    };

    final status = Status.fromJson(json);

    expect(status.id, '');
    expect(status.bikesAvailable, 0);
    expect(status.bikesDisabled, 0);
    expect(status.status, StatusEnum.IN_SERVICE);
    expect(status.docksAvailable, 0);
    expect(status.docksDisabled, 0);
    expect(status.lastReported, 0);
    expect(status.isInstalled, false);
    expect(status.isRenting, false);
    expect(status.isReturning, false);
    expect(status.vehicleTypesAvailable.length, 0);
  });
}