import 'dart:io';

import 'package:agile_unify/components/custom_button.dart';
import 'package:agile_unify/components/error_box.dart';
import 'package:agile_unify/components/replace_flatbutton.dart';
import 'package:agile_unify/core/core.dart';
import 'package:agile_unify/core/button_animation.dart';
import 'package:agile_unify/stores/signup_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final SignupStore signupStore = SignupStore();
  File userFoto;

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
                          GestureDetector(
                            onTap: () {
                              editarFoto(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 85.0),
                              width: 140.0,
                              height: 140.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: userFoto != null
                                      ? FileImage(File(userFoto.path))
                                      : AssetImage(AppImages.userPurpleIcon),
                                ),
                              ),
                            ),
                          ),
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
                Observer(builder: (_) {
                  if (animationStatus == 0)
                    return Padding(
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
                    );
                  return StaggerAnimation(
                      buttonController: signupButtonController.view);
                }),
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
      duration: Duration(seconds: 2),
    ));
  }

  void editarFoto(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          "Tirar Foto",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        onPressed: () {
                          // Navigator.pop(context);
                          // ImagePicker.pickImage(source: ImageSource.camera)
                          //     .then((file) {
                          //   if (file == null) return;
                          //   setState(() {
                          //     userFoto = file;
                          //   });
                          // });
                        },
                      ),
                      Divider(),
                      TextButton(
                        child: Text(
                          "Abrir Galeria",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        onPressed: () {
                          // Navigator.pop(context);
                          // ImagePicker.pickImage(
                          //         source: ImageSource.gallery, maxWidth: 1920)
                          //     .then((file) {
                          //   if (file == null) return;
                          //   setState(() {
                          //     userFoto = file;
                          //   });
                          // });
                        },
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
