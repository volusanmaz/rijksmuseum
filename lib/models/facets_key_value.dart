import 'dart:convert';

class FacetsKeyValue {
  final String key;
  final int value;

  FacetsKeyValue({
    required this.key,
    required this.value,
  });

  factory FacetsKeyValue.fromJson(Map<String, dynamic> json) {
    return FacetsKeyValue(
      key: json['key'] ?? "",
      value: json['value'] ?? 0,
    );
  }
}