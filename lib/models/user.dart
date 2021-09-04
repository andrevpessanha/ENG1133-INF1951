class User {
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.createdAt,
  });

  String id;
  String name;
  String email;
  String password;
  DateTime createdAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, createdAt: $createdAt}';
  }
}
