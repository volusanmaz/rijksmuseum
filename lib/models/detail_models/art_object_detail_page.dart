
import 'package:rijksmuseum/models/detail_models/ad_lib_overrides.dart';

class ArtObjectDetailPage {
  final String id;
  final List<dynamic> similarPages;
  final String lang;
  final String objectNumber;
  final List<dynamic> tags;
  final String? plaqueDescription;
  final String? audioFile1;
  final String? audioFileLabel1;
  final String? audioFileLabel2;
  final DateTime createdOn;
  final DateTime updatedOn;
  final AdlibOverrides adlibOverrides;

  ArtObjectDetailPage({
    required this.id,
    required this.similarPages,
    required this.lang,
    required this.objectNumber,
    required this.tags,
    required this.plaqueDescription,
    required this.audioFile1,
    required this.audioFileLabel1,
    required this.audioFileLabel2,
    required this.createdOn,
    required this.updatedOn,
    required this.adlibOverrides,
  });

  factory ArtObjectDetailPage.fromJson(Map<String, dynamic> json) {
    return ArtObjectDetailPage(
      id: json['id'],
      similarPages: json['similarPages'],
      lang: json['lang'],
      objectNumber: json['objectNumber'],
      tags: json['tags'],
      plaqueDescription: json['plaqueDescription']??"PlaqueDescription : No Description",
      audioFile1: json['audioFile1'],
      audioFileLabel1: json['audioFileLabel1'],
      audioFileLabel2: json['audioFileLabel2'],
      createdOn: DateTime.parse(json['createdOn']),
      updatedOn: DateTime.parse(json['updatedOn']),
      adlibOverrides: AdlibOverrides.fromJson(json['adlibOverrides']),
    );
  }
}