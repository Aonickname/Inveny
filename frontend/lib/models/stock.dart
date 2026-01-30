class Stock {
  final int? id;
  final String name;
  final int quantity;
  final String unit;
  final String? category;
  final String location;
  final String? memo;

  Stock({
    this.id, 
    required this.name, 
    required this.quantity, 
    required this.unit,
    this.category,
    required this.location,
    this.memo
    });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
      category: json['category'],
      location: json['location'] ?? '주방',
      memo: json['memo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'category': category,
      'location': location,
      'memo': memo,
    };
  }
}