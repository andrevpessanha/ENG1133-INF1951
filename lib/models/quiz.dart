import 'package:agile_unify/models/category.dart';
import 'package:agile_unify/models/question.dart';

class Quiz {
  Quiz({
    this.id,
    this.title,
    this.description,
    this.category,
    this.questionsJsonUrl,
    this.questions,
  });

  final String id;
  final String title;
  final String description;
  final Category category;
  final String questionsJsonUrl;
  List<Question> questions;
}
