import 'package:agile_unify/models/question.dart';
import 'package:agile_unify/models/quiz.dart';
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
          print('BUSCANDO QUESTIONS');
          setLoading(true);
          await getQuizQuestions();
          print(
              'PRONTO! ' + homeStore.selectedQuiz.questions.length.toString());

          setError(null);
          setLoading(false);
        } catch (e) {
          setError(e.toString());
        }
      }
    });
  }

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
