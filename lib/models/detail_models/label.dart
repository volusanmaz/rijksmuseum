class Label {
  final String? title;
  final String? makerLine;
  final String? description;
  final String? notes;
  final DateTime? date;

  Label({
    required this.title,
    required this.makerLine,
    required this.description,
    required this.date,
    this.notes,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      title: json['title'],
      makerLine: json['makerLine'],
      description: json['description'],
      notes: json['notes'],
      date: DateTime.parse(json['date']),
    );
  }
}