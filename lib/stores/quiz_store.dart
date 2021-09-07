import 'package:agile_unify/repositories/quiz_repository.dart';
import 'package:agile_unify/stores/home_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'quiz_store.g.dart';

class QuizStore = _QuizStore with _$QuizStore;

abstract class _QuizStore with Store {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  _QuizStore() {
    autorun((_) async {
      if (homeStore.selectedQuiz != null &&
          homeStore.selectedQuiz.questions == null) {
        try {
          setLoading(true);
          await getQuizQuestions();

          setError(null);
          setLoading(false);
        } catch (e) {
          setError(e.toString());
        }
      }
      reset();
    });
  }

  @observable
  bool answerSelected = false;

  @action
  resetAnswerSelected() => answerSelected = false;

  @observable
  int correctAnswers = 0;

  @action
  void onSelected(bool value) {
    answerSelected = true;
    if (value) {
      correctAnswers++;
    }
  }

  @action
  void reset() => correctAnswers = 0;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @action
  Future<void> getQuizQuestions() async {
    try {
      await QuizRepository().getQuizQuestions();
    } catch (e) {
      setError(e.toString());
    }
  }
}
