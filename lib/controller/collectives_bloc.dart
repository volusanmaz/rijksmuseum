import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:rijksmuseum/models/collection_models/art_object.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CollectivesBloc {
  // Singleton instance
  static CollectivesBloc _instance = CollectivesBloc._internal();

  factory CollectivesBloc() {
    return _instance;
  }



  // HTTP client instance
  http.Client httpClient = http.Client();

  CollectivesBloc._internal();

  // StreamController for broadcasting stream
  final _artObjectsController = StreamController<List<ArtObject>>.broadcast();

  // Getter for the broadcast stream
  Stream<List<ArtObject>> get artObjectsStream => _artObjectsController.stream;

  // Method to fetch data
  Future<void> fetchData() async {
    try {
      // Check internet connection
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection');
      }

      final response = await http.get(Uri.parse(MobileAppItems.collectionApiAdress("en")));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<ArtObject> artObjects = [];
        for (var json in jsonData['artObjects']) {
          artObjects.add(ArtObject.fromJson(json));
        }
        MobileAppItems.collectionData.clear();
        MobileAppItems.collectionData = artObjects;
        _artObjectsController.sink.add(artObjects);
      } else {
        throw Exception('Failed to load data with code ${response.statusCode}');
      }
    } catch (e) {
      _artObjectsController.addError(e);
      throw Exception('Failed to load data with error: $e');
    }
  }

  // Dispose method
  void dispose() {
    _artObjectsController.close();
  }
}