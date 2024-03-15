import 'package:rijksmuseum/models/collection_models/header_image.dart';
import 'package:rijksmuseum/models/collection_models/web_image.dart';

class ArtObject {
  final String selfLink;
  final String webLink;
  final String id;
  final String objectNumber;
  final String title;
  final bool hasImage;
  final String principalOrFirstMaker;
  final String longTitle;
  final bool showImage;
  final bool permitDownload;
  final WebImage? webImage;
  final HeaderImage? headerImage;
  final List<String>? productionPlaces;
  bool showLongTitle=false;

  ArtObject({
    required this.selfLink,
    required this.webLink,
    required this.id,
    required this.objectNumber,
    required this.title,
    required this.hasImage,
    required this.principalOrFirstMaker,
    required this.longTitle,
    required this.showImage,
    required this.permitDownload,
    required this.webImage,
    required this.headerImage,
    required this.productionPlaces,
  });

  factory ArtObject.fromJson(Map<String, dynamic> json) {
    final bool containsImage = json['hasImage']  ;
    return ArtObject(
      selfLink: json['links']['self'],
      webLink: json['links']['web'],
      id: json['id']??"",
      objectNumber: json['objectNumber']??"",
      title: json['title']??"",
      hasImage: json['hasImage']??"",
      principalOrFirstMaker: json['principalOrFirstMaker']??"",
      longTitle: json['longTitle']??"",
      showImage: json['showImage']??"",
      permitDownload: json['permitDownload']??"",
      webImage: containsImage?WebImage.fromJson(json['webImage']): null,
      headerImage: containsImage?HeaderImage.fromJson(json['headerImage']):null,
      productionPlaces: List<String>.from(json['productionPlaces'] ?? []),
    );
  }
}
