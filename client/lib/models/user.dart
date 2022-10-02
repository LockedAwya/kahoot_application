import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'token': token
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      username: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJSON() {
    return json.encode(toMap());
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: name ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }
}
