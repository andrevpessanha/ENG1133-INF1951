import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:agile_unify/components/custom_drawer/page_tile.dart';
import 'package:agile_unify/screens/login/login_screen.dart';
import 'package:agile_unify/stores/page_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';

class PageSection extends StatelessWidget {
  final PageStore pageStore = GetIt.I<PageStore>();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    Future<void> verifyLoginAndSetPage(int page) async {
      if (userManagerStore.isLoggedIn) {
        if (pageStore.page != page) pageStore.setPage(page);
        Navigator.of(context).pop();
      } else {
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    }

    return Column(
      children: [
        PageTile(
          label: 'Simulados',
          iconData: Icons.school,
          onTap: () {
            if (pageStore.page != 0) pageStore.setPage(0);
            Navigator.of(context).pop();
          },
          highlighted: pageStore.page == 0,
        ),
        PageTile(
          label: 'Cursos Acessíveis',
          iconData: Icons.bolt,
          onTap: () {
            verifyLoginAndSetPage(1);
          },
          highlighted: pageStore.page == 1,
        ),
        PageTile(
          label: 'Cursos Gratuitos',
          iconData: Icons.star_rate,
          onTap: () {
            verifyLoginAndSetPage(2);
          },
          highlighted: pageStore.page == 2,
        ),
        PageTile(
          label: 'Minha Conta',
          iconData: Icons.person,
          onTap: () {
            verifyLoginAndSetPage(3);
          },
          highlighted: pageStore.page == 3,
        ),
        userManagerStore.isLoggedIn
            ? Column(
                children: [
                  PageTile(
                    label: 'Sair',
                    iconData: Icons.logout,
                    onTap: () {
                      userManagerStore.logout();
                      Navigator.of(context).pop();
                    },
                    highlighted: pageStore.page == 4,
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
