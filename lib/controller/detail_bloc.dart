import 'dart:async';
import 'package:rijksmuseum/controller/mobile_app_consts.dart';
import 'package:http/http.dart' as http;
import 'package:rijksmuseum/models/detail_models/art_object_detail_response.dart';
import 'dart:convert';

class DetailBloc {
  final _detailDataController = StreamController<ArtObjectResponse>.broadcast();

  Stream<ArtObjectResponse> get detailDataStream => _detailDataController.stream;

  Future<void> fetchData(String selfLink) async {

    try {
      final response = await http.get(Uri.parse(selfLink));

        if (response.statusCode == 200) {
          Map<String, dynamic> jsonData = json.decode(response.body);
          ArtObjectResponse artObject = ArtObjectResponse.fromJson(jsonData);

          MobileAppItems.detailData = null;
          MobileAppItems.detailData = artObject;

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