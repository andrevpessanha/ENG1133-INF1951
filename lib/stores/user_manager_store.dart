import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:agile_unify/models/user.dart';
import 'package:agile_unify/repositories/user_repository.dart';

import 'home_store.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  _UserManagerStore() {
    _getCurrentUser();
  }

  @observable
  User user;

  @action
  void updateUserScore(String quizID, double score, int qtdQuizzes) {
    user.quizzesScore.update(quizID, (value) => score, ifAbsent: () => score);
    if (score == 1.0) {
      user.qtdUniqueCompletedQuizzes++;
      user.score = user.qtdUniqueCompletedQuizzes / qtdQuizzes;
    }

    String jsonQuizzesScore = json.encode(user.quizzesScore);
    UserRepository().updateUserScore(user, score, jsonQuizzesScore);
  }

  @observable
  bool readyToFetchQuizzes;

  @action
  setReadyToFetchQuizzes(bool value) => readyToFetchQuizzes = value;

  @action
  void setUser(User value) {
    print('SET USER');
    user = value;
    print('RESET PAGE');
    GetIt.I<HomeStore>().resetPage();
  }

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
