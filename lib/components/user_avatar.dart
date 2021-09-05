import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UserAvatar extends StatelessWidget {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 15.0),
        alignment: Alignment.center,
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: userManagerStore.isLoggedIn
                  ? userManagerStore.user.photo != ""
                      ? NetworkImage(userManagerStore.user.photo)
                      : AssetImage("assets/images/user.png")
                  : AssetImage("assets/images/user.png"),
            ),
          ),
        ));
  }
}
