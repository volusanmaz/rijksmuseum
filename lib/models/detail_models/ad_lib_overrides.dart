class AdlibOverrides {
  final String? titel;
  final String? maker;
  final String? etiketText;

  AdlibOverrides({
    required this.titel,
    required this.maker,
    required this.etiketText,
  });

  factory AdlibOverrides.fromJson(Map<String, dynamic> json) {
    return AdlibOverrides(
      titel: json['titel'],
      maker: json['maker'],
      etiketText: json['etiketText'],
    );
  }
}