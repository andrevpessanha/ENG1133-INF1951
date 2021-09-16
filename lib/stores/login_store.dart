import 'package:agile_unify/repositories/user_repository.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:agile_unify/helpers/extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError =>
      email == null || emailValid ? null : 'E-mail inválido';

  @observable
  String password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password.length >= 4;
  String get passwordError =>
      password == null || passwordValid ? null : 'Senha inválida';

  @computed
  bool get isFormValid => emailValid && passwordValid;

  @computed
  Function get loginPressed =>
      emailValid && passwordValid && !loading ? _login : null;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @action
  Future<void> _login() async {
    setLoading(true);
    error = null;

    try {
      final user = await UserRepository().loginWithEmail(email, password);
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e;
    }

    setLoading(false);
  }

  @computed
  Function get recoverPressed => (emailValid && !loading) ? _recover : null;

  @observable
  bool success = false;

  @action
  void setSuccess(bool value) => success = value;

  Future<void> _recover() async {
    setLoading(true);

    try {
      await UserRepository().recoverPassword(email);
      setSuccess(true);
    } catch (_) {
      setError(error);
    }

    setLoading(false);
  }
}
