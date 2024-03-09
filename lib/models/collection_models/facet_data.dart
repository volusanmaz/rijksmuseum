import 'package:rijksmuseum/models/collection_models/facets_key_value.dart';

class FacetData {
  final List<FacetsKeyValue> facets;
  final String name;
  final int otherTerms;
  final int prettyName;

  FacetData({
    required this.facets,
    required this.name,
    required this.otherTerms,
    required this.prettyName,
  });

  factory FacetData.fromJson(Map<String, dynamic> json) {
    List<dynamic> facetsList = json['facets'] ?? [];
    List<FacetsKeyValue> facetsData =
    facetsList.map((item) => FacetsKeyValue.fromJson(item)).toList();

    return FacetData(
      facets: facetsData,
      name: json['name'] ?? "",
      otherTerms: json['otherTerms'] ?? 0,
      prettyName: json['prettyName'] ?? 0,
    );
  }
}