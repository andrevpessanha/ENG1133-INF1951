import 'package:agile_unify/models/user.dart';
import 'package:agile_unify/repositories/parse_errors.dart';
import 'package:agile_unify/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserRepository {
  Future<User> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<num>(keyUserScore, 0.0);
    parseUser.set<num>(keyUserQtdCompletedQuizzes, 0);
    if (user.photo != null) parseUser.set<String>(keyUserPhoto, user.photo);

    final response = await parseUser.signUp();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> currentUser() async {
    final parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response.success) {
        return mapParseToUser(response.result);
      } else {
        await parseUser.logout();
      }
    }
    return null;
  }

  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId,
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      photo: parseUser.get(keyUserPhoto),
      score: parseUser.get(keyUserScore),
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }

  Future<void> save(User user) async {
    final ParseUser parseUser = await ParseUser.currentUser();

    if (parseUser != null) {
      parseUser.set<String>(keyUserName, user.name);

      if (user.password != null) {
        parseUser.password = user.password;
      }

      final response = await parseUser.save();

      if (!response.success)
        return Future.error(ParseErrors.getDescription(response.error.code));

      if (user.password != null) {
        await parseUser.logout();

        final loginResponse =
            await ParseUser(user.email, user.password, user.email).login();

        if (!loginResponse.success)
          return Future.error(ParseErrors.getDescription(response.error.code));
      }
    }
  }

  Future<void> logout() async {
    final ParseUser currentUser = await ParseUser.currentUser();
    await currentUser.logout();
  }

  Future<void> recoverPassword(String email) async {
    final ParseUser user = ParseUser(email.toLowerCase(), '', email);
    final ParseResponse parseResponse = await user.requestPasswordReset();
    if (!parseResponse.success)
      return Future.error(ParseErrors.getDescription(parseResponse.error.code));
  }

  Future<void> userIncrementQtdCompletedQuizzes(User user) async {
    final ParseCloudFunction function =
        ParseCloudFunction('userIncrementQtdCompletedQuizzes');
    final Map<String, String> params = <String, String>{'id': user.id};

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
