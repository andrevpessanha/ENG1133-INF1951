class Question {
  Question({
    this.title,
    this.answers,
    this.correctAnswer,
  });

  final String title;
  final List<String> answers;
  final int correctAnswer;

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        title: map['title'],
        answers: List<String>.from(
          map['answers'].map((x) => x['title']).toList(),
        ),
        correctAnswer: map['correctAnswer']);
  }
}
