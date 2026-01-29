
import 'package:mockito/mockito.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:t5_1/viewmodel/viewmodel.dart';
import 'package:t5_1/main.dart' as app;

import '../viewmodel_test.mocks.dart';

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Prueba de integración del sistema completo', (tester) async {
      
      Viewmodel viewmodel;
      viewmodel = Viewmodel();
      var mockApiInformation = MockApiInformation(); 
      var mockApiStatus = MockApiStatus();
      viewmodel.apiInformation = mockApiInformation; 
      viewmodel.apiStatus = mockApiStatus;
      when(mockApiStatus.getPostsJson())
          .thenAnswer((_) async => {
                'last_updated': 1704067200,
                'ttl': 60,
                'version': '2.3',
                'data': {
                  'stations': [
                    {
                      "station_id": "3",
                      "num_bikes_available": 12,
                      "num_bikes_disabled": 2,
                      "is_charging_station": true,
                      "status": "IN_SERVICE",
                      "traffic": null,
                      "num_docks_available": 15,
                      "num_docks_disabled": 0,
                      "last_reported": 1769710790,
                      "is_installed": true,
                      "is_renting": true,
                      "is_returning": true,
                      "vehicle_docks_available": [
                        {
                          "vehicle_type_ids": [
                            "FIT",
                            "EFIT",
                            "BOOST"
                          ],
                          "count": 15
                        }
                      ],
                      "vehicle_types_available": [
                        {
                          "vehicle_type_id": "FIT",
                          "count": 9
                        },
                        {
                          "vehicle_type_id": "BOOST",
                          "count": 0
                        },
                        {
                          "vehicle_type_id": "EFIT",
                          "count": 3
                        }
                      ]
                    },
                  ]
                }
              });

      when(mockApiInformation.getPostsJson())
          .thenAnswer((_) async => {
            "last_updated": 1738245600,
            "ttl": 3600,
            "version": "2.3",
            "data": {
              "stations": [
                {
                  "station_id": "3",
                  "name": "Plaza De Pontevedra",
                  "physical_configuration": "ELECTRICBIKESTATION",
                  "lat": 43.3680112,
                  "lon": -8.4066505,
                  "altitude": 0,
                  "address": "R. San Andrés, 164",
                  "post_code": "15003",
                  "capacity": 29,
                  "is_charging_station": true,
                  "geofenced_capacity": 0,
                  "rental_methods": [
                    "key",
                    "transitcard",
                    "creditcard",
                    "phone"
                  ],
                  "is_virtual_station": false,
                  "groups": [],
                  "obcn": "3",
                  "short_name": "3",
                  "nearby_distance": 500,
                  "_bluetooth_id": "da93",
                  "_ride_code_support": true,
                  "rental_uris": {

                  }
                },
              ]
            }
          });
      app.main();
      await tester.pumpAndSettle();
      await viewmodel.getData();  

      viewmodel.favStationStatus = viewmodel.statusData.isNotEmpty ? viewmodel.statusData.first : null;
      viewmodel.favStationInformation = viewmodel.infoData.isNotEmpty ? viewmodel.infoData.first : null;

      expect(find.text("Actualizado por última vez: ${viewmodel.favStationStatus!.lastReported}"), findsOneWidget);
      await tester.tap(find.byElementType(PieChart));

      await tester.tap(find.text("Aquarium"));
      await tester.pumpAndSettle();

      expect(find.text("Detalle de la estación"), findsOneWidget);

      await tester.tap(find.byElementType(ListTile).at(3));
      await tester.pumpAndSettle();

      expect(find.text("Home Screen"), findsOneWidget);
      expect(find.text("Actualizado por última vez: ${viewmodel.favStationStatus!.lastReported}"), findsOneWidget);

      await tester.tap(find.text("Aquarium"));
      await tester.pumpAndSettle();

      expect(find.text("Detalle de la estación"), findsOneWidget);
      await tester.tap(find.backButton());
      await tester.pumpAndSettle();
      expect(find.text("Home Screen"), findsOneWidget);
  });
}