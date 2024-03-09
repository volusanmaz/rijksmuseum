class WebImageDetail {
  final String guid;
  final int offsetPercentageX;
  final int offsetPercentageY;
  final int width;
  final int height;
  final String url;

  WebImageDetail({
    required this.guid,
    required this.offsetPercentageX,
    required this.offsetPercentageY,
    required this.width,
    required this.height,
    required this.url,
  });

  factory WebImageDetail.fromJson(Map<String, dynamic> json) {
    return WebImageDetail(
      guid: json['guid'],
      offsetPercentageX: json['offsetPercentageX'],
      offsetPercentageY: json['offsetPercentageY'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
    );
  }
}