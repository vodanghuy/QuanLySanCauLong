class San {
  final int id;
  final String name;
  final bool isBooked;

  San({required this.id, required this.name, required this.isBooked});

  factory San.fromJson(Map<String, dynamic> json) {
    return San(
      id: json['id'],
      name: json['name'],
      isBooked: json['isBooked'],
    );
  }
}
