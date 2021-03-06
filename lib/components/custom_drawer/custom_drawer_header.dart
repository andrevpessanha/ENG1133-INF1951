import 'package:agile_unify/core/app_colors.dart';
import 'package:agile_unify/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:agile_unify/screens/login/login_screen.dart';
import 'package:agile_unify/stores/page_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';

class CustomDrawerHeader extends StatelessWidget {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();

        if (userManagerStore.isLoggedIn) {
          GetIt.I<PageStore>().setPage(0);
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => LoginScreen()));
        }
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 8.0),
          color: AppColors.purple,
          height: 170,
          child: Stack(
            children: [
              Positioned(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 80.0),
                    width: userManagerStore.isLoggedIn ? 80.0 : 75.0,
                    height: userManagerStore.isLoggedIn ? 80.0 : 75.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: userManagerStore.isLoggedIn
                              ? userManagerStore.user.photo != null
                                  ? NetworkImage(userManagerStore.user.photo)
                                  : AssetImage(AppImages.userWhiteIcon)
                              : AssetImage(AppImages.userWhiteIcon),
                        )),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                      !userManagerStore.isLoggedIn
                          ? "Ol??, seja bem-vindo!"
                          : "Ol??, ${userManagerStore.user.name}!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  !userManagerStore.isLoggedIn
                      ? Text("Entrar ou Criar Conta",
                          style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold))
                      : Container(),
                ],
              ))
            ],
          )),
    );
  }
}
