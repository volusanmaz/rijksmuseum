import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:http/http.dart' as http;
import 'package:rijksmuseum/models/detail_models/art_object_detail_response.dart';
import 'dart:convert';

class DetailBloc {

  // HTTP client instance
  http.Client httpClient = http.Client();
  Connectivity connectivity=Connectivity();


  static bool containsImage=true;
  static ArtObjectResponse? detailData=null;
  static String detailLink="";
  final _detailDataController = StreamController<ArtObjectResponse>.broadcast();

  Stream<ArtObjectResponse> get detailDataStream => _detailDataController.stream;

  Future<void> fetchData(String selfLink) async {

    try {

      // Check internet connection
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection');
      }
      final response = await httpClient.get(Uri.parse(selfLink));

        if (response.statusCode == 200) {
          Map<String, dynamic> jsonData = json.decode(response.body);
          ArtObjectResponse artObject = ArtObjectResponse.fromJson(jsonData);

          detailData = null;
          detailData = artObject;

          _detailDataController.sink.add(artObject);

        } else {

          throw Exception('Failed to load data response code ${response.statusCode} ');

        }


    } catch (e) {

      _detailDataController.addError(e);
      throw Exception('Failed to load data with error: $e');
    }
  }

  void dispose() {
    _detailDataController.close();
  }
}