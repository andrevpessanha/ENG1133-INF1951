import 'package:agile_unify/components/error_box.dart';
import 'package:agile_unify/components/replace_raisedbutton.dart';
import 'package:agile_unify/core/app_colors.dart';
import 'package:agile_unify/stores/signup_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

final SignupStore signupStore = SignupStore();

class _SignUpScreenState extends State<SignUpScreen> {
  TextStyle titleStyle = TextStyle(
    color: Colors.grey[800],
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
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
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ErrorBox(message: signupStore.error),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4),
                    child: Text('Nome', style: titleStyle),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !signupStore.loading,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Informe seu nome',
                          isDense: true,
                          errorText: signupStore.nameError),
                      onChanged: signupStore.setName,
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4),
                    child: Text('E-mail', style: titleStyle),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !signupStore.loading,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Informe seu e-mail',
                          isDense: true,
                          errorText: signupStore.emailError),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      onChanged: signupStore.setEmail,
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4),
                    child: Text('Senha', style: titleStyle),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !signupStore.loading,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Informe sua senha',
                          isDense: true,
                          errorText: signupStore.pass1Error),
                      obscureText: true,
                      onChanged: signupStore.setPass1,
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4),
                    child: Text('Senha', style: titleStyle),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Confirme sua senha',
                            isDense: true,
                            errorText: signupStore.pass2Error),
                        obscureText: true,
                        onChanged: signupStore.setPass2);
                  }),
                  Observer(builder: (_) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 12),
                      height: 40,
                      child: ReplaceRaisedButton(
                        color: AppColors.purple,
                        disabledColor: AppColors.purple,
                        child: signupStore.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColors.purple),
                              )
                            : Text('CADASTRAR'),
                        textColor: Colors.white,
                        elevation: 16,
                        onPressed: () {
                          signupStore.signUpPressed();
                          Navigator.popUntil(context,
                              ModalRoute.withName(Navigator.defaultRouteName));
                        },
                      ),
                    );
                  }),
                  Divider(color: AppColors.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        const Text('Já tem uma conta? ',
                            style: TextStyle(fontSize: 16)),
                        GestureDetector(
                          onTap: Navigator.of(context).pop,
                          child: Text(
                            'Entrar',
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
