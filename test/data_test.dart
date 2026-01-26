// Generar mocks: dart run build_runner build

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ApiInformation])
import 'package:t5_1/data/simple_api_information.dart';
import 'package:t5_1/data/simple_repository_information.dart';
import 'package:test/test.dart';
@GenerateNiceMocks([MockSpec<ApiInformation>()])
import 'data_test.mocks.dart';

void main(){
  group('SimpleApiTests', (){
    late MockApiInformation apiInformation;
    late RepositoryInformation repositoryInformation;

    setUp((){
      apiInformation = MockApiInformation();
      repositoryInformation = RepositoryInformation(apiInformation);
    });

    test('Devuelve información correcta si la API devuelve datos válidos', () async {
      final mockResponse = {
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
      };

      when(apiInformation.getPostsJson())
          .thenAnswer((_) async => mockResponse);

      final data = await repositoryInformation.obtenerInformation();
  
      expect(data.data.stations.isNotEmpty, true);
    });

    test('Lanza una excepción si la API devuelve un error', () async {
      when(apiInformation.getPostsJson())
          .thenThrow(Exception('Error de red'));

      expect(
        () async => await repositoryInformation.obtenerInformation(),
        throwsA(isA<Exception>()),
      );
    });

  });
}