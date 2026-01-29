import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([], customMocks: [
  MockSpec<ApiInformation>(as: #BotUpMockApiInformation)
])
import 'package:t5_1/data/simple_api_information.dart';

@GenerateMocks([], customMocks: [
  MockSpec<ApiStatus>(as: #BotUpMockApiStatus)
])
import 'package:t5_1/data/simple_api_status.dart';
import 'package:t5_1/model/information.dart';
import 'package:t5_1/model/status.dart';
import 'package:t5_1/viewmodel/viewmodel.dart';

import 'bottom_up_integration_test.mocks.dart';

void main() {
  group("Bottom-up test de integración", (){
    late BotUpMockApiInformation mockApiInformation;
    late BotUpMockApiStatus mockApiStatus;
    late Viewmodel viewmodel;

    setUp(() {
      mockApiInformation = BotUpMockApiInformation();
      mockApiStatus = BotUpMockApiStatus();
      viewmodel = Viewmodel();
      viewmodel.apiInformation = mockApiInformation;
      viewmodel.apiStatus = mockApiStatus;
    });

    test('Integración de ApiInformation y ApiStatus con viewmodel', () async {
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
      await viewmodel.getData();  

      final infoJson = await mockApiInformation.getPostsJson();
      final statusJson = await mockApiStatus.getPostsJson();

      expect(infoJson['data']['stations'][0]['station_id'],"3");
      expect(statusJson['data']['stations'][0]['num_bikes_available'], 12);

      expect(viewmodel.infoData[0] == InformationStation.fromJson(infoJson), true);
      expect(viewmodel.statusData[0] == StatusResponse.fromJson(statusJson).data.status[0], true);
    });
  });
}