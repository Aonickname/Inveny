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

  // 1. 서버나 DB에서 받은 데이터를 붕어빵 틀(객체)에 넣기
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

  // 2. 붕어빵(객체)을 다시 데이터베이스에 저장하기 좋게 맵(Map)으로 바꾸기
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