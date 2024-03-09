import 'package:rijksmuseum/models/header_image.dart';
import 'package:rijksmuseum/models/web_image.dart';

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
  final WebImage webImage;
  final HeaderImage headerImage;
  final List<String> productionPlaces;
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
    return ArtObject(
      selfLink: json['links']['self'],
      webLink: json['links']['web'],
      id: json['id'],
      objectNumber: json['objectNumber'],
      title: json['title'],
      hasImage: json['hasImage'],
      principalOrFirstMaker: json['principalOrFirstMaker'],
      longTitle: json['longTitle'],
      showImage: json['showImage'],
      permitDownload: json['permitDownload'],
      webImage: WebImage.fromJson(json['webImage']),
      headerImage: HeaderImage.fromJson(json['headerImage']),
      productionPlaces: List<String>.from(json['productionPlaces'] ?? []),
    );
  }
}
