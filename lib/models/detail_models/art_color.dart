class ArtColor {
  final int percentage;
  final String hex;

  ArtColor({
    required this.percentage,
    required this.hex,
  });

  factory ArtColor.fromJson(Map<String, dynamic> json) {
    return ArtColor(
      percentage: json['percentage'],
      hex: json['hex'],
    );
  }
}