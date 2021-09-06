import 'package:agile_unify/components/user_avatar.dart';
import 'package:agile_unify/core/app_colors.dart';
import 'package:agile_unify/screens/home/components/quiz_card.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:agile_unify/components/custom_drawer/custom_drawer.dart';
import 'package:agile_unify/components/empty_card.dart';
import 'package:agile_unify/stores/home_store.dart';

import 'components/categories_widget.dart';
import 'components/score_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = GetIt.I<HomeStore>();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: const Text('Simulados'),
          centerTitle: true,
          actions: <Widget>[
            UserAvatar(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Observer(builder: (_) {
                if (userManagerStore.isLoggedIn)
                  return Align(
                    alignment: Alignment(0.0, 1.0),
                    child: ScoreCard(percent: 0.85),
                  );
                return Align(
                  alignment: Alignment(0.0, 1.0),
                  child: ScoreCard(percent: 0),
                );
              }),
              Observer(builder: (_) {
                return CategoriesWidget(homeStore.category);
              }),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Observer(builder: (_) {
                      if (homeStore.error != null)
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.error,
                                color: AppColors.purple,
                                size: 100,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Ocorreu um erro!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        );
                      if (homeStore.showProgress)
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.purple),
                          ),
                        );
                      if (homeStore.quizList.isEmpty)
                        return EmptyCard('Nenhum simulado encontrado! 🤷🏻‍♀️');

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.0,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        itemCount: homeStore.itemCount,
                        itemBuilder: (_, index) {
                          if (index < homeStore.quizList.length)
                            return QuizCard(homeStore.quizList[index], index);

                          homeStore.loadNextPage();
                          return Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.purple),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
