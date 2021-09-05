// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuizStore on _QuizStore, Store {
  final _$answerSelectedAtom = Atom(name: '_QuizStore.answerSelected');

  @override
  bool get answerSelected {
    _$answerSelectedAtom.reportRead();
    return super.answerSelected;
  }

  @override
  set answerSelected(bool value) {
    _$answerSelectedAtom.reportWrite(value, super.answerSelected, () {
      super.answerSelected = value;
    });
  }

  final _$correctAnswersAtom = Atom(name: '_QuizStore.correctAnswers');

  @override
  int get correctAnswers {
    _$correctAnswersAtom.reportRead();
    return super.correctAnswers;
  }

  @override
  set correctAnswers(int value) {
    _$correctAnswersAtom.reportWrite(value, super.correctAnswers, () {
      super.correctAnswers = value;
    });
  }

  final _$loadingAtom = Atom(name: '_QuizStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_QuizStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$getQuizQuestionsAsyncAction =
      AsyncAction('_QuizStore.getQuizQuestions');

  @override
  Future<void> getQuizQuestions() {
    return _$getQuizQuestionsAsyncAction.run(() => super.getQuizQuestions());
  }

  final _$_QuizStoreActionController = ActionController(name: '_QuizStore');

  @override
  dynamic resetAnswerSelected() {
    final _$actionInfo = _$_QuizStoreActionController.startAction(
        name: '_QuizStore.resetAnswerSelected');
    try {
      return super.resetAnswerSelected();
    } finally {
      _$_QuizStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelected(bool value) {
    final _$actionInfo =
        _$_QuizStoreActionController.startAction(name: '_QuizStore.onSelected');
    try {
      return super.onSelected(value);
    } finally {
      _$_QuizStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo =
        _$_QuizStoreActionController.startAction(name: '_QuizStore.reset');
    try {
      return super.reset();
    } finally {
      _$_QuizStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo =
        _$_QuizStoreActionController.startAction(name: '_QuizStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_QuizStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String value) {
    final _$actionInfo =
        _$_QuizStoreActionController.startAction(name: '_QuizStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_QuizStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
answerSelected: ${answerSelected},
correctAnswers: ${correctAnswers},
loading: ${loading},
error: ${error}
    ''';
  }
}
