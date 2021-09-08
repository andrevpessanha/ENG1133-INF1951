class User {
  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.photo,
      this.createdAt,
      this.quizzesScore,
      this.score,
      this.qtdUniqueCompletedQuizzes});

  String id;
  String name;
  String email;
  String password;
  String photo;
  DateTime createdAt;
  Map<String, dynamic> quizzesScore;
  num score = 0.0;
  int qtdUniqueCompletedQuizzes = 0;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, createdAt: $createdAt, score: $score, uniqueCompletedQuizzes: $qtdUniqueCompletedQuizzes}';
  }
}
