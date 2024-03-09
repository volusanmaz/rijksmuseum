class ArtColorWithNormalization {
  final String originalHex;
  final String normalizedHex;

  ArtColorWithNormalization({
    required this.originalHex,
    required this.normalizedHex,
  });

  factory ArtColorWithNormalization.fromJson(Map<String, dynamic> json) {
    return ArtColorWithNormalization(
      originalHex: json['originalHex'],
      normalizedHex: json['normalizedHex'],
    );
  }
}