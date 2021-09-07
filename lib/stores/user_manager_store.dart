import 'package:mobx/mobx.dart';
import 'package:agile_unify/models/user.dart';
import 'package:agile_unify/repositories/user_repository.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  _UserManagerStore() {
    _getCurrentUser();
  }

  @observable
  User user;

  @observable
  final Map<String, dynamic> userQuizzesScore = {'*': 0.0};

  @action
  void updateUserQuizzesScore(String index, double score) {
    userQuizzesScore.update(index, (value) => score, ifAbsent: () => score);
  }

  @observable
  bool readyToFetchQuizzes;

  @action
  setReadyToFetchQuizzes(bool value) => readyToFetchQuizzes = value;

  @action
  void setUser(User value) => user = value;

  @computed
  bool get isLoggedIn => user != null;

  Future<void> _getCurrentUser() async {
    setReadyToFetchQuizzes(false);
    final user = await UserRepository().currentUser();
    setUser(user);
    setReadyToFetchQuizzes(true);
  }

  Future<void> logout() async {
    await UserRepository().logout();
    setUser(null);
  }

  void incrementQtdCompletedQuizzes() {
    try {
      UserRepository().userIncrementQtdCompletedQuizzes(user);
    } catch (e) {
      print(e);
    }
  }
}
