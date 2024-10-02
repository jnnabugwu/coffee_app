import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:coffee_app/core/services/local_database.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/core/config/api_config.dart';
import 'package:coffee_app/data/coffee_datasource.dart';

import 'coffee_datasource_test.mocks.dart';

@GenerateMocks([http.Client, DatabaseHelper])
void main() {
  late CoffeeDataSourceImpl dataSource;
  late MockClient mockHttp;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockHttp = MockClient();
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = CoffeeDataSourceImpl(mockDatabaseHelper, httpClient: mockHttp);
  });

  group('getCoffee', () {
    test('should return a CoffeeModel with a valid URL when the http call completes successfully', () async {
      // Arrange
      when(mockHttp.get(Uri.parse(ApiConfig.randomCoffeeEndpoint)))
          .thenAnswer((_) async => http.Response(
            '{"file": "https://coffee.alexflipnote.dev/random_id_coffee.png"}',
            200
          ));

      // Act
      final result = await dataSource.getCoffee();

      // Assert
      expect(result, isA<CoffeeModel>());
      expect(result?.file, isNotNull);
      expect(result?.file, isA<String>());
      expect(result?.file, startsWith('https://coffee.alexflipnote.dev/'));
      expect(result?.file, endsWith('.png'));
    });

    test('should return null when the http call completes with no file data', () async {
      // Arrange
      when(mockHttp.get(Uri.parse(ApiConfig.randomCoffeeEndpoint)))
          .thenAnswer((_) async => http.Response('{"somethingElse": "data"}', 200));

      // Act
      final result = await dataSource.getCoffee();

      // Assert
      expect(result, isNull);
    });
    
    test('should throw an Exception when the http call completes with an error', () async {
      // Arrange
      when(mockHttp.get(Uri.parse(ApiConfig.randomCoffeeEndpoint)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(
        () => dataSource.getCoffee(),
        throwsA(isA<Exception>()),
      );
    });
  });
}