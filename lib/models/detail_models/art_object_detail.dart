import 'package:rijksmuseum/models/detail_models/art_color.dart';
import 'package:rijksmuseum/models/detail_models/art_color_with_normalization.dart';
import 'package:rijksmuseum/models/detail_models/art_dimension.dart';
import 'package:rijksmuseum/models/detail_models/label.dart';
import 'package:rijksmuseum/models/detail_models/web_image_detail.dart';

class ArtObjectDetail {
  final String id;
  final String objectNumber;
  final String title;
  final WebImageDetail webImage;
  final List<ArtColor> colors;
  final List<ArtColorWithNormalization> colorsWithNormalization;
  final List<ArtColor> normalizedColors;
  final List<ArtDimension> dimensions;
  final String longTitle;
  final String subTitle;
  final String scLabelLine;
  final Label label;
  final List<dynamic> documentation;
  final String principalOrFirstMaker;
  final String location;
  ArtObjectDetail({
    required this.id,
    required this.objectNumber,
    required this.title,
    required this.webImage,
    required this.colors,
    required this.normalizedColors,
    required this.colorsWithNormalization,
    required this.dimensions,
    required this.longTitle,
    required this.subTitle,
    required this.scLabelLine,
    required this.label,
    required this.documentation,
    required this.principalOrFirstMaker,
    required this.location
  });

  factory ArtObjectDetail.fromJson(Map<String, dynamic> json) {
    return ArtObjectDetail(
      id: json['id'],
      objectNumber: json['objectNumber'],
      title: json['title'],
      webImage: WebImageDetail.fromJson(json['webImage']),
      colors: (json['colors'] as List<dynamic>).map((colorJson) => ArtColor.fromJson(colorJson)).toList(),
      normalizedColors: (json['normalizedColors'] as List<dynamic>).map((colorJson) => ArtColor.fromJson(colorJson)).toList(),
      colorsWithNormalization: (json['colorsWithNormalization'] as List<dynamic>).map((colorJson) => ArtColorWithNormalization.fromJson(colorJson)).toList(),
      dimensions: (json['dimensions'] as List<dynamic>).map((dimensionJson) => ArtDimension.fromJson(dimensionJson)).toList(),
      longTitle: json['longTitle'],
      subTitle: json['subTitle'],
      scLabelLine: json['scLabelLine'],
      label: Label.fromJson(json['label']),
      documentation: json['documentation'],
      principalOrFirstMaker: json['principalOrFirstMaker'],
      location: json['location']

    );
  }
}