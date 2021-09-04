// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CourseStore on _CourseStore, Store {
  final _$errorAtom = Atom(name: '_CourseStore.error');

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

  final _$_CourseStoreActionController = ActionController(name: '_CourseStore');

  @override
  void setFreeCourses(List<Course> courses) {
    final _$actionInfo = _$_CourseStoreActionController.startAction(
        name: '_CourseStore.setFreeCourses');
    try {
      return super.setFreeCourses(courses);
    } finally {
      _$_CourseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAccessibleCourses(List<Course> courses) {
    final _$actionInfo = _$_CourseStoreActionController.startAction(
        name: '_CourseStore.setAccessibleCourses');
    try {
      return super.setAccessibleCourses(courses);
    } finally {
      _$_CourseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String value) {
    final _$actionInfo = _$_CourseStoreActionController.startAction(
        name: '_CourseStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CourseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error}
    ''';
  }
}
