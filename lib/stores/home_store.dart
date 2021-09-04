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
      //Aguardar até que a sessão do usuário
      // seja validada e impede erros de sessão
      if (!userManagerStore.readyToFetchQuizzes) return;
      try {
        final newQuizzes = await QuizRepository().getHomeQuizList(
          category: category,
          page: page,
        );
        addNewQuizzes(newQuizzes);
        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e.toString());
      }
    });
  }

  ObservableList<Quiz> quizList = ObservableList<Quiz>();

  @observable
  Quiz selectedQuiz;

  @action
  void setSelectedQuiz(int index) => selectedQuiz = quizList[index];

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

  // void incrementViews(Ad ad) {
  //   try {
  //     AdRepository().incrementViews(ad);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

}
