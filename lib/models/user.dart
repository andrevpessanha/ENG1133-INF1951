class User {
  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.photo,
      this.createdAt,
      this.score,
      this.completedQuizzes});

  String id;
  String name;
  String email;
  String password;
  String photo;
  DateTime createdAt;
  num score;
  num completedQuizzes;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, createdAt: $createdAt, score: $score}';
  }
}
