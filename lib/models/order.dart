class Order {
  String? id;
  String? orderId;
  String? vehicleId;
  String? from;
  String? to;
  String? status;
  int? distance;

  Order({
    this.id,
    this.orderId,
    this.from,
    this.to,
    this.status,
    this.distance,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderId: json['orderId'],
      from: json['from'],
      to: json['to'],
      status: json['status'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'from': from,
      'to': to,
      'status': status,
      'distance': distance,
    };
  }
}
