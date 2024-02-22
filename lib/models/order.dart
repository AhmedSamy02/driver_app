class Order {
  String? id;
  String? title;
  String? from;
  String? to;
  String? status;
  int? distance;

  Order({
    this.id,
    this.title,
    this.from,
    this.to,
    this.status,
    this.distance,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      title: json['title'],
      from: json['from'],
      to: json['to'],
      status: json['status'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'from': from,
      'to': to,
      'status': status,
      'distance': distance,
    };
  }
}
