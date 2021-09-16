import 'dart:io';

import 'package:agile_unify/components/custom_button.dart';
import 'package:agile_unify/components/error_box.dart';
import 'package:agile_unify/components/image_source_modal.dart';
import 'package:agile_unify/components/replace_flatbutton.dart';
import 'package:agile_unify/core/core.dart';
import 'package:agile_unify/core/button_animation.dart';
import 'package:agile_unify/stores/signup_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final SignupStore signupStore = SignupStore();

  AnimationController signupButtonController;
  var animationStatus = 0;

  TextStyle titleStyle = TextStyle(
    color: Colors.grey[800],
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  Future<Null> playAnimation() async {
    try {
      await signupButtonController.forward();
      await signupButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  void initState() {
    super.initState();

    signupButtonController = new AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  dispose() {
    signupButtonController.dispose();
    super.dispose();
  }

  void onImageSelected(File image) {
    signupStore.setPhoto(image);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Observer(builder: (_) {
                            return ErrorBox(
                              message: signupStore.error,
                            );
                          }),
                          SizedBox(height: 10),
                          GestureDetector(onTap: () {
                            if (Platform.isAndroid) {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) =>
                                    ImageSourceModal(onImageSelected),
                              );
                            } else {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (_) =>
                                    ImageSourceModal(onImageSelected),
                              );
                            }
                          }, child: Observer(builder: (_) {
                            if (signupStore.userPhoto == null)
                              return CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 55,
                                  backgroundImage:
                                      AssetImage(AppImages.userPurpleIcon));
                            else if (signupStore.userPhoto is File)
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 55,
                                backgroundImage:
                                    FileImage(signupStore.userPhoto),
                              );

                            return CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 55,
                              backgroundImage:
                                  NetworkImage(signupStore.userPhoto.path),
                            );
                          })),
                          SizedBox(height: 10.0),
                          Observer(builder: (_) {
                            return TextField(
                              enabled: !signupStore.loading,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.purple,
                                    ),
                                  ),
                                  hintText: "Nome",
                                  errorText: signupStore.nameError),
                              onChanged: signupStore.setName,
                            );
                          }),
                          SizedBox(height: 10.0),
                          Observer(builder: (_) {
                            return TextField(
                              enabled: !signupStore.loading,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.purple,
                                    ),
                                  ),
                                  hintText: "E-mail",
                                  errorText: signupStore.emailError),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              onChanged: signupStore.setEmail,
                            );
                          }),
                          SizedBox(height: 10.0),
                          Observer(builder: (_) {
                            return TextField(
                              enabled: !signupStore.loading,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.purple,
                                  ),
                                ),
                                hintText: "Senha",
                                errorText: signupStore.pass1Error,
                              ),
                              obscureText: true,
                              onChanged: signupStore.setPass1,
                            );
                          }),
                          SizedBox(height: 10.0),
                          Observer(builder: (_) {
                            return TextField(
                              enabled: !signupStore.loading,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.purple,
                                  ),
                                ),
                                hintText: "Confirmar Senha",
                                errorText: signupStore.pass2Error,
                              ),
                              obscureText: true,
                              onChanged: signupStore.setPass2,
                            );
                          }),
                          SizedBox(height: 110.0),
                        ],
                      ),
                    ),
                  ],
                ),
                animationStatus == 0
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: InkWell(
                          onTap: () {
                            if (signupStore.isFormValid) {
                              signupStore.signUpPressed();
                              onSuccess();
                            } else
                              return null;
                          },
                          child: CustomButton("Cadastrar"),
                        ),
                      )
                    : StaggerAnimation(
                        buttonController: signupButtonController.view),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Já possui conta?", style: TextStyle(fontSize: 14.0)),
                    ReplaceFlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Entrar",
                          style: TextStyle(
                              fontSize: 14.0, color: AppColors.purple)),
                    ),
                  ],
                ),
              ],
            ),
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
