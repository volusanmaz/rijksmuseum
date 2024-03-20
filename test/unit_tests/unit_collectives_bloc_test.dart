import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mocktail/mocktail.dart';
import 'package:rijksmuseum/controller/collectives_bloc.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:rijksmuseum/models/collection_models/art_object.dart';

// Mock classes
class MockConnectivity extends Mock implements Connectivity {}
class MockHttpClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('http://www.rijksmuseum.nl/api/en/collection?key=0fiuZFh4&culture=en&p=50&ps=100'));
    MobileAppItems.apiKey='0fiuZFh4';
 });

  group('CollectivesBloc Tests', () {
    late MockConnectivity mockConnectivity;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockConnectivity = MockConnectivity();
      mockHttpClient = MockHttpClient();
      // Reset mocks
      reset(mockConnectivity);
      reset(mockHttpClient);
      // Inject mock instances
      CollectivesBloc instance = CollectivesBloc();
      instance.connectivity = mockConnectivity;
      instance.httpClient = mockHttpClient;
    });

    // Test data
    final testData = {
      'artObjects': [
        {
          'links': {'self': 'link1', 'web': 'webLink1'},
          'id': '1',
          'objectNumber': 'obj1',
          'title': 'Test Title 1',
          'hasImage': true,
          'principalOrFirstMaker': 'Maker 1',
          'longTitle': 'Long Title 1',
          'showImage': false,
          'permitDownload': true,
          'webImage': {
            'guid': null,
            'offsetPercentageX': null,
            'offsetPercentageY': null,
            'width':null,
            'height': null,
            'url': null
          },
          'headerImage': {
            'guid': null,
            'offsetPercentageX': null,
            'offsetPercentageY': null,
            'width': null,
            'height': null,
            'url': null
          },
          'productionPlaces': []
        }
      ]
    };


    test('fetchData successfully fetches data', () async {
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response(jsonEncode(testData), 200));


      expectLater(
        CollectivesBloc().artObjectsStream,
        emits(isA<List<ArtObject>>()),
      );

      await CollectivesBloc().fetchData();
    });

    test('fetchData emits an error when there is no internet connection', () async {

      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.none);
      final bloc = CollectivesBloc();


      await expectLater(
        bloc.fetchData(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'description', contains("No internet"))),
      );

    });

  });
}
