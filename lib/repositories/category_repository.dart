import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:agile_unify/models/category.dart';
import 'package:agile_unify/repositories/parse_errors.dart';
import 'package:agile_unify/repositories/table_keys.dart';

class CategoryRepository {
  Category mapParseToCategory(ParseObject object) {
    return Category(id: object.objectId, title: object.get(keyCategoryTitle));
  }

  Future<List<Category>> getList() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyCategoryTitle);

    final response = await queryBuilder.query();

    if (response.success) {
      return response.results.map((p) => mapParseToCategory(p)).toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }
}
