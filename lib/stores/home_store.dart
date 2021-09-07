import 'dart:convert';

import 'package:agile_unify/models/category.dart';
import 'package:agile_unify/models/quiz.dart';
import 'package:agile_unify/repositories/quiz_repository.dart';
import 'package:agile_unify/stores/connectivity_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  _HomeStore() {
    autorun((_) async {
      setLoading(true);

      final newCategory = category;
      final newPage = page;

      print('INICIOU LEITURA');
      if (!userManagerStore.readyToFetchQuizzes) return;
      try {
        if (!hasReadUserPreferences) {
          // Executa uma vez após iniciar o App
          print('LENDO USER PREFERENCES');
          final preferences = await SharedPreferences.getInstance();
          if (preferences.containsKey('USER_QUIZZES_SCORE')) {
            print('TEM DADOS');
            final userData = json.decode(preferences.get('USER_QUIZZES_SCORE'));
            final newQuizzes = await QuizRepository().getHomeQuizList(
              category: newCategory,
              page: newPage,
              userData: userData,
            );
            addNewQuizzes(newQuizzes);

            setHasReadUserPreferences(true);
          } else {
            print('SEM DADOS');
            final newQuizzes = await QuizRepository().getHomeQuizList(
              category: newCategory,
              page: newPage,
            );
            addNewQuizzes(newQuizzes);
          }
        } else {
          print('LEITURA DEFAULT');
          final newQuizzes = await QuizRepository().getHomeQuizList(
            category: newCategory,
            page: newPage,
          );
          addNewQuizzes(newQuizzes);
        }
        print('CONCLUIU LEITURA');
        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e.toString());
      }
    });
  }

  ObservableList<Quiz> quizList = ObservableList<Quiz>();

  @observable
  bool hasReadUserPreferences = false;

  @action
  void setHasReadUserPreferences(bool value) => hasReadUserPreferences = value;

  @observable
  int selectedQuizIndex = 0;

  @observable
  Quiz selectedQuiz;

  @action
  void setSelectedQuiz(int index) {
    selectedQuizIndex = index;
    selectedQuiz = quizList[index];
  }

  @observable
  Category category = Category(id: '*', title: 'Todas');

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  int page = 0;

  @observable
  bool lastPage = false;

  @action
  void loadNextPage() {
    page++;
  }

  @action
  void addNewQuizzes(List<Quiz> newQuizzes) {
    if (newQuizzes.length < 10) lastPage = true;
    quizList.addAll(newQuizzes);
  }

  @computed
  int get itemCount => lastPage ? quizList.length : quizList.length + 1;

  void resetPage() {
    page = 0;
    quizList.clear();
    lastPage = false;
  }

  @computed
  bool get showProgress => loading && quizList.isEmpty;

  Future<void> updateQuizScore(double score) async {
    selectedQuiz.score = score;
    quizList[selectedQuizIndex].score = score;

    print('ATUALIZANDO LISTA');
    userManagerStore.updateUserQuizzesScore(selectedQuiz.id, score);
    print('SALVANDO NAS PREFERENCES');
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(
        'USER_QUIZZES_SCORE', json.encode(userManagerStore.userQuizzesScore));
    print('SALVOU NAS PREFERENCES');
  }

  void incrementQtdCompleted() {
    try {
      QuizRepository().incrementQtdCompleted(selectedQuiz);
    } catch (e) {
      print(e);
    }
  }
}
