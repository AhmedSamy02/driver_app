class vehicle {
  String? id;
  String? title;
  String? address;
  int? fuelLevel;

  vehicle({this.id, this.title, this.address, this.fuelLevel});

  factory vehicle.fromJson(Map<String, dynamic> json) {
    return vehicle(
      id: json['id'],
      title: json['title'],
      address: json['address'],
      fuelLevel: json['fuelLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'fuelLevel': fuelLevel,
    };
  }
}
