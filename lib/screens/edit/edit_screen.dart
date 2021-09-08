import 'dart:io';

import 'package:agile_unify/components/custom_button.dart';
import 'package:agile_unify/components/custom_drawer/custom_drawer.dart';
import 'package:agile_unify/components/image_source_modal.dart';
import 'package:agile_unify/core/core.dart';
import 'package:agile_unify/core/button_animation.dart';
import 'package:agile_unify/stores/edit_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen>
    with SingleTickerProviderStateMixin {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final EditStore editStore = EditStore();

  AnimationController editButtonController;
  var animationStatus = 0;

  TextStyle titleStyle = TextStyle(
    color: Colors.grey[800],
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  Future<Null> playAnimation() async {
    try {
      await editButtonController.forward();
      await editButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  void initState() {
    super.initState();

    editButtonController = new AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  dispose() {
    editButtonController.dispose();
    super.dispose();
  }

  void onImageSelected(File image) {
    editStore.setPhoto(image);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Conta"),
          centerTitle: true,
        ),
        drawer: CustomDrawer(),
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
                            if (userManagerStore.user.photo != null) {
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 55,
                                backgroundImage:
                                    NetworkImage(userManagerStore.user.photo),
                              );
                            } else if (editStore.userPhoto == null)
                              return CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 55,
                                  backgroundImage:
                                      AssetImage(AppImages.userPurpleIcon));
                            else if (editStore.userPhoto is File)
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 55,
                                backgroundImage: FileImage(editStore.userPhoto),
                              );
                            return Container();
                          })),
                          SizedBox(height: 10.0),
                          Observer(builder: (_) {
                            return TextFormField(
                              initialValue: editStore.name,
                              enabled: !editStore.loading,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.purple,
                                    ),
                                  ),
                                  hintText: "Nome",
                                  errorText: editStore.nameError),
                              onChanged: editStore.setName,
                            );
                          }),
                          SizedBox(height: 10.0),
                          Observer(builder: (_) {
                            return TextField(
                              enabled: !editStore.loading,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.purple,
                                  ),
                                ),
                                hintText: "Nova Senha",
                              ),
                              obscureText: true,
                              onChanged: editStore.setPass1,
                            );
                          }),
                          SizedBox(height: 10.0),
                          Observer(builder: (_) {
                            return TextField(
                              enabled: !editStore.loading,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.purple,
                                  ),
                                ),
                                hintText: "Confirmar Senha",
                                errorText: editStore.passError,
                              ),
                              obscureText: true,
                              onChanged: editStore.setPass2,
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
                            if (editStore.isFormValid) {
                              editStore.savePressed();
                              onSuccess();
                            } else
                              return null;
                          },
                          child: CustomButton("Salvar"),
                        ),
                      )
                    : StaggerAnimation(
                        buttonController: editButtonController.view),
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
}
