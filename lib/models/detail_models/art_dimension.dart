class ArtDimension {
  final String unit;
  final String type;
  final String? precision;
  final String? part;
  final String value;

  ArtDimension({
    required this.unit,
    required this.type,
    this.precision,
    this.part,
    required this.value,
  });

  factory ArtDimension.fromJson(Map<String, dynamic> json) {
    return ArtDimension(
      unit: json['unit'],
      type: json['type'],
      precision: json['precision'],
      part: json['part'],
      value: json['value'],
    );
  }
}