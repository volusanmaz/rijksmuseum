import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rijksmuseum/models/collection_models/art_object.dart';
import 'package:rijksmuseum/pages/home_screen.dart';
import 'package:rijksmuseum/pages/splash_screen.dart';
import 'package:rijksmuseum/controller/collectives_bloc.dart';

// Mock class for CollectivesBloc
class MockCollectivesBloc extends Mock implements CollectivesBloc {}

void main() {

  Map<String, dynamic> artObjectJson = {
    "links": {
      "self": "https://api.rijksmuseum.nl/object/1",
      "web": "https://www.rijksmuseum.nl/en/collection/1"
    },
    "id": "1",
    "objectNumber": "SK-A-1505",
    "title": "The Milkmaid",
    "hasImage": true,
    "principalOrFirstMaker": "Johannes Vermeer",
    "longTitle": "The Milkmaid, Johannes Vermeer, c. 1660",
    "showImage": true,
    "permitDownload": true,
    "webImage": {
      "guid": "0a0b0c0d",
      "offsetPercentageX": 50,
      "offsetPercentageY": 50,
      "width": 2500,
      "height": 2500,
      "url": "https://www.rijksmuseum.nl/web-image.jpg"
    },
    "headerImage": {
      "guid": "1a2b3c4d",
      "offsetPercentageX": 50,
      "offsetPercentageY": 50,
      "width": 1920,
      "height": 1080,
      "url": "https://www.rijksmuseum.nl/header-image.jpg"
    },
    "productionPlaces": ["Delft", "Netherlands"]
  };

  // Creating an ArtObject instance from JSON
  ArtObject artObject = ArtObject.fromJson(artObjectJson);
  // Create a mock instance of CollectivesBloc
  final mockCollectivesBloc = MockCollectivesBloc();

  // Widget test for SplashScreen
  group('SplashScreen Tests', () {
    testWidgets('shows loading indicator while waiting for data', (WidgetTester tester) async {
      // Mock the artObjectsStream to simulate waiting for data
      when(() => mockCollectivesBloc.artObjectsStream).thenAnswer(
            (_) => Stream.value([artObject,artObject,artObject]), // Simulate an empty list initially
      );

      // Build our app and trigger a frame
      await tester.pumpWidget(MaterialApp(home: SplashScreen(collectivesBloc: mockCollectivesBloc)));

      // Verify that a CircularProgressIndicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when data fails to load', (WidgetTester tester) async {
      // Mock the artObjectsStream to simulate an error
      when(() => mockCollectivesBloc.artObjectsStream).thenAnswer(
            (_) => Stream.error('No internet connection'),
      );

      // Build our app and trigger a frame
      await tester.pumpWidget(MaterialApp(home: SplashScreen(collectivesBloc: mockCollectivesBloc)));

      // Verify that the error message is shown
      expect(find.text('No internet connection'), findsOneWidget);
    });

    testWidgets('navigates to next page when data is loaded', (WidgetTester tester) async {
      // Mock the artObjectsStream to simulate data being loaded successfully
      when(() => mockCollectivesBloc.artObjectsStream).thenAnswer(
            (_) => Stream.value([artObject]),
      );

      // Build our app and trigger a frame
      await tester.pumpWidget(MaterialApp(home: SplashScreen(collectivesBloc: mockCollectivesBloc)));

      // Pump until the next page animation starts
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}