import 'package:flutter/foundation.dart';

class QuizController {
  final currentPageNotifier = ValueNotifier<int>(1);
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  int correctAnswers = 0;
}
