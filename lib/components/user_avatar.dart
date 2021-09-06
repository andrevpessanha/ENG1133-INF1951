import 'package:agile_unify/core/app_images.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class UserAvatar extends StatelessWidget {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 15.0),
        alignment: Alignment.center,
        child: Observer(builder: (_) {
          return Container(
            width: 40.0,
            height: 40.0,
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
              ),
            ),
          );
        }));
  }
}
