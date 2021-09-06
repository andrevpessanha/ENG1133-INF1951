import 'dart:io';

class User {
  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.photo,
      this.createdAt,
      this.score});

  String id;
  String name;
  String email;
  String password;
  String photo;
  DateTime createdAt;
  num score;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, createdAt: $createdAt, score: $score}';
  }
}
