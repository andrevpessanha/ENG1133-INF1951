import 'package:agile_unify/components/custom_button.dart';
import 'package:agile_unify/components/error_box.dart';
import 'package:agile_unify/components/replace_flatbutton.dart';
import 'package:agile_unify/core/app_colors.dart';
import 'package:agile_unify/core/button_animation.dart';
import 'package:agile_unify/screens/signup/signup_screen.dart';
import 'package:agile_unify/stores/login_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final LoginStore loginStore = LoginStore();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  AnimationController loginButtonController;
  var animationStatus = 0;

  Future<Null> playAnimation() async {
    try {
      await loginButtonController.forward();
      await loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  void initState() {
    super.initState();

    loginButtonController = new AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  dispose() {
    loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Entrar'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 80.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Observer(builder: (_) {
                                  return ErrorBox(
                                    message: loginStore.error,
                                  );
                                }),
                                SizedBox(height: 10),
                                Observer(builder: (_) {
                                  return TextField(
                                    enabled: !loginStore.loading,
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.purple,
                                          ),
                                        ),
                                        hintText: "E-mail",
                                        errorText: loginStore.emailError),
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    onChanged: loginStore.setEmail,
                                  );
                                }),
                                SizedBox(height: 10.0),
                                Observer(builder: (_) {
                                  return TextField(
                                    enabled: !loginStore.loading,
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.purple,
                                        ),
                                      ),
                                      hintText: "Senha",
                                      errorText: loginStore.passwordError,
                                    ),
                                    obscureText: true,
                                    onChanged: loginStore.setPassword,
                                  );
                                }),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ReplaceFlatButton(
                                    onPressed: () {
                                      if (!loginStore.emailValid) {
                                        onFail(
                                            errorMsg:
                                                "Informe um e-mail válido para recuperar a senha",
                                            error: true);
                                      } else {
                                        loginStore.recoverPressed();
                                        onFail(
                                            errorMsg: "Confira seu e-mail!",
                                            error: false);
                                      }
                                    },
                                    padding: EdgeInsets.zero,
                                    child: Text("Esqueci minha senha",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: AppColors.purple)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                animationStatus == 0
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 70.0),
                        child: InkWell(
                          onTap: () {
                            if (loginStore.isFormValid) {
                              loginStore.loginPressed();
                              onSuccess();
                            } else
                              return null;
                          },
                          child: CustomButton("Entrar"),
                        ),
                      )
                    : StaggerAnimation(
                        buttonController: loginButtonController.view),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Não possui conta?", style: TextStyle(fontSize: 14.0)),
                    ReplaceFlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                      child: Text("Criar Conta",
                          style: TextStyle(
                              fontSize: 14.0, color: AppColors.purple)),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  void onSuccess() {
    setState(() {
      animationStatus = 1;
    });
    playAnimation();
  }

  void onFail({@required String errorMsg, @required bool error}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        errorMsg,
        textAlign: TextAlign.center,
      ),
      backgroundColor:
          (error) ? Colors.redAccent : Theme.of(context).primaryColor,
      duration: Duration(seconds: 3),
    ));
  }
}
