import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:t5_1/data/simple_repository_information.dart';
import 'package:t5_1/viewmodel/viewmodel.dart';
import 'package:test/test.dart';

@GenerateMocks([ApiInformation])
import 'package:t5_1/data/simple_api_information.dart';

@GenerateMocks([ApiStatus])
import 'package:t5_1/data/simple_api_status.dart';

import 'viewmodel_test.mocks.dart';


void main() {
  group("Capa de ViewModel", () {
    late MockApiInformation mockApiInformation;
    late MockApiStatus mockApiStatus;
    late Viewmodel viewmodel;
    setUp(() {
      mockApiInformation = MockApiInformation(); 
      mockApiStatus = MockApiStatus();
      viewmodel = Viewmodel();
      viewmodel.apiInformation = mockApiInformation;
      viewmodel.apiStatus = mockApiStatus;
    });
    test('Loading funciona correctamente', () {
      when(mockApiInformation.getPostsJson())
          .thenAnswer((_) async => await Future.delayed(Duration(seconds: 1), () => {
                'last_updated': 1625247600,
                'ttl': 300,
                'data': {
                  'stations': [
                    {
                      'station_id': '123',
                      'name': 'Station 123',
                      'lat': 43.3623,
                      'lon': -8.4115,
                    },
                  ],
                },
                'version': '1.0.0',
              }));
      when(mockApiStatus.getPostsJson())
          .thenAnswer((_) async => await Future.delayed(Duration(seconds: 1), () => {
                'data': [
                  {
                    'station_id': '123',
                    'num_bikes_available': 5,
                    'num_ebikes_available': 2,
                    'num_bikes_disabled': 0,
                    'num_docks_available': 10,
                    'num_docks_disabled': 0,
                    'is_installed': 1,
                    'is_renting': 1,
                    'is_returning': 1,
                    'last_reported': 1625247600,
                    'eightd_has_available_keys': true,
                  },
                ],
              }));
      viewmodel.getData();
      expect(viewmodel.loading, true);
      Future.delayed(Duration(seconds: 3), () {
        expect(viewmodel.loading, false);
      });
    }
    
    );
    test('Manejo de errores funciona correctamente', () async {
      when(mockApiInformation.getPostsJson())
          .thenThrow(Exception('Error de red'));
      when(mockApiStatus.getPostsJson())
          .thenThrow(Exception('Error de red'));
      await viewmodel.getData();
      expect(viewmodel.error, isNotNull);
      expect(viewmodel.loading, false);
    });
    test('Obtención de datos funciona correctamente', () async {
      when(mockApiStatus.getPostsJson())
          .thenAnswer((_) async => {
                'last_updated': 1704067200,
                'ttl': 60,
                'version': '2.3',
                'data': {
                  'stations': [
                    {
                      'station_id': 'station_001',
                      'num_bikes_available': 12,
                      'num_bikes_disabled': 1,
                      'status': 'IN_SERVICE',
                      'num_docks_available': 18,
                      'num_docks_disabled': 0,
                      'last_reported': 1704067100,
                      'is_installed': true,
                      'is_renting': true,
                      'is_returning': true,
                      'vehicle_types_available': [
                        
                      ]
                    }
                  ]
                }
              });

      when(mockApiInformation.getPostsJson())
          .thenAnswer((_) async => {
                'last_updated': 1704067200,
                'ttl': 3600,
                'version': '2.1',
                'data': {
                  'stations': [
                    {
                      'station_id': 'station_001',
                      'name': 'Estación Central',
                      'physical_configuration': 'ANCHORAGE',
                      'lat': 40.4168,
                      'lon': -3.7038,
                      'altitude': 655,
                      'address': 'Calle Principal 123',
                      'post_code': '28001',
                      'capacity': '30',
                      'is_charging_station': true,
                      'geofenced_capacity': 30,
                      'rental_methods': ['APP', 'CREDITCARD']
                    }
                  ]
                }
              });
      await viewmodel.getData();
      expect(viewmodel.infoData.isNotEmpty, true);
      expect(viewmodel.statusData.isNotEmpty, true);
      expect(viewmodel.error, isNull);
    });
  });
}