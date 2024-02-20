class User {
  String? id;
  String? name;
  String? email;
  String? username;
  String? token;
  User({this.name, this.email, this.username, this.token, this.id});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      token: json['token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'token': token,
    };
  }
}
