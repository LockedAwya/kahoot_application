class User {
  String token = "";
  String id = "";
  String email = "";
  String username = "";
  String password = "";

  User(
      {required this.token,
      required this.id,
      required this.email,
      required this.username,
      required this.password});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        token: json["token"],
        id: json["_id"],
        email: json["email"],
        username: json["username"],
        password: json["password"]);
  }
}
