import 'package:agile_unify/models/course.dart';
import 'package:agile_unify/repositories/parse_errors.dart';
import 'package:agile_unify/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CourseRepository {
  Future<List<Course>> getFreeCoursesList() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCourseTable))
      ..whereEqualTo('type', CourseType.FREE.index)
      ..orderByDescending(keyCourseTitle);

    final response = await queryBuilder.query();

    if (response.success) {
      return response.results.map((p) => mapParseToCourse(p)).toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }

  Future<List<Course>> getAccessibleCoursesList() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCourseTable))
      ..whereEqualTo('type', CourseType.ACCESSIBLE.index)
      ..orderByDescending(keyCourseTitle);

    final response = await queryBuilder.query();

    if (response.success) {
      return response.results.map((p) => mapParseToCourse(p)).toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }

  Course mapParseToCourse(ParseObject object) {
    final file = object.get<ParseFileBase>(keyCourseImage);
    return Course(
      id: object.objectId,
      title: object.get<String>(keyCourseTitle),
      description: object.get<String>(keyCourseDescription),
      type: CourseType.values[object.get(keyCourseType)],
      image: file.url,
      url: object.get<String>(keyCourseUrl),
    );
  }
}
