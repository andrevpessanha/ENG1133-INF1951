import 'package:agile_unify/models/course.dart';
import 'package:agile_unify/repositories/course_repository.dart';
import 'package:agile_unify/stores/page_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'course_store.g.dart';

class CourseStore = _CourseStore with _$CourseStore;

abstract class _CourseStore with Store {
  _CourseStore() {
    autorun((_) {
      final currentPage = GetIt.I<PageStore>().page;
      if (currentPage == 1)
        _loadAccessibleCourses();
      else if (currentPage == 2) _loadFreeCourses();
    });
  }

  ObservableList<Course> freeCourseList = ObservableList<Course>();

  @action
  void setFreeCourses(List<Course> courses) {
    freeCourseList.clear();
    freeCourseList.addAll(courses);
  }

  ObservableList<Course> accessibleCourseList = ObservableList<Course>();

  @action
  void setAccessibleCourses(List<Course> courses) {
    accessibleCourseList.clear();
    accessibleCourseList.addAll(courses);
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  Future<void> _loadFreeCourses() async {
    try {
      final courses = await CourseRepository().getFreeCoursesList();
      setFreeCourses(courses);
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> _loadAccessibleCourses() async {
    try {
      final courses = await CourseRepository().getAccessibleCoursesList();
      setAccessibleCourses(courses);
    } catch (e) {
      setError(e.toString());
    }
  }
}
