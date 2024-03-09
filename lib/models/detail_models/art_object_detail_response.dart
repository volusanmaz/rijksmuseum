import 'package:rijksmuseum/models/detail_models/art_object_detail.dart';
import 'package:rijksmuseum/models/detail_models/art_object_detail_page.dart';

class ArtObjectResponse {
  final int elapsedMilliseconds;
  final ArtObjectDetail artObject;
  final ArtObjectDetailPage artObjectPage;

  ArtObjectResponse({
    required this.elapsedMilliseconds,
    required this.artObject,
    required this.artObjectPage,
  });

  factory ArtObjectResponse.fromJson(Map<String, dynamic> json) {
    return ArtObjectResponse(
      elapsedMilliseconds: json['elapsedMilliseconds'],
      artObject: ArtObjectDetail.fromJson(json['artObject']),
      artObjectPage: ArtObjectDetailPage.fromJson(json['artObjectPage']),
    );
  }
}