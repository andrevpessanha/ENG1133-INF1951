import 'package:agile_unify/models/category.dart';
import 'package:agile_unify/models/quiz.dart';
import 'package:agile_unify/repositories/quiz_repository.dart';
import 'package:agile_unify/stores/connectivity_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

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

      if (!userManagerStore.readyToFetchQuizzes) return;
      try {
        if (!firstRead) {
          if (userManagerStore.user?.quizzesScore != null) {
            await _updateHomeScreen(
                newCategory, newPage, userManagerStore.user.quizzesScore);
          } else {
            await _updateHomeScreen(newCategory, newPage, null);
          }

          setFirstRead(true);
        } else {
          await _updateHomeScreen(newCategory, newPage,
              userManagerStore.user?.quizzesScore ?? null);
        }

        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e.toString());
      }
    });
  }

  Future<void> _updateHomeScreen(
      Category category, int page, Map<String, dynamic> userData) async {
    final newQuizzes = await QuizRepository().getHomeQuizList(
      category: category,
      page: page,
      userData: userData,
    );
    addNewQuizzes(newQuizzes);
  }

  ObservableList<Quiz> quizList = ObservableList<Quiz>();

  bool firstRead = false;

  void setFirstRead(bool value) => firstRead = value;

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

  Future<void> updateUserScore(double score) async {
    selectedQuiz.score = score;
    quizList[selectedQuizIndex].score = score;

    userManagerStore.updateUserScore(selectedQuiz.id, score, quizList.length);
  }

  void incrementQtdCompleted() {
    try {
      QuizRepository().incrementQtdCompleted(selectedQuiz);
    } catch (e) {
      print(e);
    }
  }
}
