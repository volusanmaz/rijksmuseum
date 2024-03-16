import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:rijksmuseum/models/collection_models/art_object.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CollectivesBloc {
  // Singleton instance
  static CollectivesBloc _instance = CollectivesBloc._internal(MobileAppItems.numberOfItems);

  factory CollectivesBloc() {
    return _instance;
  }

  int itemsPerPage;


  static List<ArtObject> collectionData=[];

  // HTTP client instance
  http.Client httpClient = http.Client();
  Connectivity connectivity=Connectivity();
  CollectivesBloc._internal(this.itemsPerPage);

  // StreamController for broadcasting stream
  final _artObjectsController = StreamController<List<ArtObject>>.broadcast();

  // Getter for the broadcast stream
  Stream<List<ArtObject>> get artObjectsStream => _artObjectsController.stream;

  // Method to fetch data
  Future<void> fetchData() async {
    try {
      List<ArtObject> artObjects = [];
      List<String> id=[];
      // Check internet connection
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection');
      }


      String url=MobileAppItems.searchText.length>0?MobileAppItems.collectionSearch(MobileAppItems.searchText):MobileAppItems.collectionApiAdress("en");

      final response = await http.get(Uri.parse(url));



      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        for (var json in jsonData['artObjects']) {

        if(!id.contains(ArtObject.fromJson(json).id)){artObjects.add(ArtObject.fromJson(json));
        }
        id.add(ArtObject.fromJson(json).id);}
        collectionData.clear();
        collectionData = artObjects;
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