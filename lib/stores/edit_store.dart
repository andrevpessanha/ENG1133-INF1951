import 'dart:io';
import 'dart:ui';

import 'package:agile_unify/models/user.dart';
import 'package:agile_unify/repositories/user_repository.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'edit_store.g.dart';

class EditStore = _EditStore with _$EditStore;

abstract class _EditStore with Store {
  _EditStore() {
    user = userManagerStore.user;
    name = user.name;
  }

  User user;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @observable
  File userPhoto;

  @action
  void setPhoto(image) => userPhoto = image;

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length > 4;
  String get nameError =>
      nameValid || name == null ? null : 'Campo obrigatório';

  @observable
  String pass1 = '';

  @action
  void setPass1(String value) => pass1 = value;

  @observable
  String pass2 = '';

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get passValid => pass1 == pass2 && (pass1.length >= 6 || pass1.isEmpty);
  String get passError {
    if (pass1.isNotEmpty && pass1.length < 6)
      return 'Senha muito curta';
    else if (pass1 != pass2) return 'Senhas não coincidem';
    return null;
  }

  @computed
  bool get isFormValid => nameValid && passValid;

  @observable
  bool loading = false;

  @computed
  VoidCallback get savePressed => (isFormValid && !loading) ? _save : null;

  @action
  Future<void> _save() async {
    loading = true;

    if (userPhoto != null) {
      ParseFileBase parseFile =
          ParseFile(File(userPhoto.path), name: 'user.jpg');
      await parseFile.save();
      user.photo = parseFile.url;
    }

    user.name = name;

    if (pass1.isNotEmpty)
      user.password = pass1;
    else
      user.password = null;

    try {
      await UserRepository().save(user);
      userManagerStore.setUser(user);
    } catch (e) {
      print(e);
    }

    loading = false;
  }

  void logout() => userManagerStore.logout();
}
