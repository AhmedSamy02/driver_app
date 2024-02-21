class Vehicle {
  String? id;
  String? title;
  String? address;
  int? fuelLevel;

  Vehicle({this.id, this.title, this.address, this.fuelLevel});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
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
