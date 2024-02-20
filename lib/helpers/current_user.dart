class CurrentUser {
  CurrentUser._();
  static final CurrentUser _instance = CurrentUser._();
  factory CurrentUser() => _instance;
  String? id;
  String? name;
  String? email;
  String? username;
  String? token;
  void setUser({
    String? id,
    String? name,
    String? email,
    String? username,
    String? token,
  }) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.username = username;
    this.token = token;
  }

  void clearUser() {
    id = null;
    name = null;
    email = null;
    username = null;
    token = null;
  }
}
