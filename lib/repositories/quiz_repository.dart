import 'package:agile_unify/models/category.dart';
import 'package:agile_unify/models/question.dart';
import 'package:agile_unify/models/quiz.dart';
import 'package:agile_unify/repositories/category_repository.dart';
import 'package:agile_unify/repositories/parse_errors.dart';
import 'package:agile_unify/stores/home_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:agile_unify/repositories/table_keys.dart';

class QuizRepository {
  Quiz mapParseToQuiz(ParseObject object) {
    final jsonFile = object.get<ParseFileBase>(keyQuizQuestions);

    return Quiz(
      id: object.objectId,
      title: object.get<String>(keyQuizTitle),
      category: CategoryRepository()
          .mapParseToCategory(object.get<ParseObject>(keyQuizCategory)),
      questionsJsonUrl: jsonFile.url,
    );
  }

  Future<List<Quiz>> getHomeQuizList({Category category, int page}) async {
    try {
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyQuizTable));

      queryBuilder.includeObject([keyQuizCategory]);

      queryBuilder.setAmountToSkip(page * 10);
      queryBuilder.setLimit(10);

      if (category != null && category.id != '*') {
        queryBuilder.whereEqualTo(
          keyQuizCategory,
          (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
              .toPointer(),
        );
      }

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        return response.results.map((po) => mapParseToQuiz(po)).toList();
      } else if (response.success && response.results == null) {
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error('Falha de conexão');
    }
  }

  Future<void> getQuizQuestions() async {
    final HomeStore homeStore = GetIt.I<HomeStore>();
    try {
      final response =
          await Dio().get<List>(homeStore.selectedQuiz.questionsJsonUrl);

      final jsonFile = response.data;

      homeStore.selectedQuiz.questions = List<Question>.from(
          jsonFile.map((x) => Question.fromMap(x)).toList());
    } on DioError catch (e) {
      print(e.toString());
      return Future.error('Falha ao obter JSON');
    }
  }

  Future<void> incrementQtdCompleted(Quiz quiz) async {
    final ParseCloudFunction function =
        ParseCloudFunction('quizIncrementQtdCompleted');
    final Map<String, String> params = <String, String>{'id': quiz.id};

    try {
      final ParseResponse parseResponse =
          await function.execute(parameters: params);
      if (!parseResponse.success) {
        return Future.error(
            ParseErrors.getDescription(parseResponse.error.code));
      }
    } catch (error) {
      Future.error('Falha ao incrementar quantidade');
    }
  }
}
