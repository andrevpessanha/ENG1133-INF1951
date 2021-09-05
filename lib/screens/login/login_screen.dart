import 'package:agile_unify/components/error_box.dart';
import 'package:agile_unify/components/replace_raisedbutton.dart';
import 'package:agile_unify/core/app_colors.dart';
import 'package:agile_unify/screens/base/base_screen.dart';
import 'package:agile_unify/screens/signup/signup_screen.dart';
import 'package:agile_unify/stores/login_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    when((_) => userManagerStore.user != null, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BaseScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Observer(builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ErrorBox(
                        message: loginStore.error,
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                    child: Text(
                      'E-mail',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !loginStore.loading,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Informe seu e-mail',
                          isDense: true,
                          errorText: loginStore.emailError),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      onChanged: loginStore.setEmail,
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Senha',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),
                        GestureDetector(
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.purple,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !loginStore.loading,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Informe sua senha',
                        isDense: true,
                        errorText: loginStore.passwordError,
                      ),
                      obscureText: true,
                      onChanged: loginStore.setPassword,
                    );
                  }),
                  Observer(builder: (_) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 12),
                      height: 40,
                      child: ReplaceRaisedButton(
                        color: AppColors.purple,
                        disabledColor: AppColors.purple,
                        child: loginStore.loading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.purple,
                                ),
                              )
                            : Text('ENTRAR'),
                        textColor: Colors.white,
                        elevation: 16,
                        onPressed: () {
                          loginStore.loginPressed();
                          // Future.delayed(Duration(seconds: 1)).then((_) {
                          //   if (GetIt.I<UserManagerStore>().isLoggedIn) {}
                          // });
                          //Navigator.of(context).pop();
                        },
                      ),
                    );
                  }),
                  Divider(
                    color: AppColors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        const Text('Não tem uma conta? ',
                            style: TextStyle(fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SignUpScreen()));
                          },
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.purple,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
