class HeaderImage {
  final String guid;
  final int offsetPercentageX;
  final int offsetPercentageY;
  final int width;
  final int height;
  final String url;

  HeaderImage({
    required this.guid,
    required this.offsetPercentageX,
    required this.offsetPercentageY,
    required this.width,
    required this.height,
    required this.url,
  });

  factory HeaderImage.fromJson(Map<String, dynamic> json) {
    return HeaderImage(
      guid: json['guid'],
      offsetPercentageX: json['offsetPercentageX'],
      offsetPercentageY: json['offsetPercentageY'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
    );
  }}