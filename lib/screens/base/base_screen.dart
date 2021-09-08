import 'package:agile_unify/screens/course/accessible_courses_screen.dart';
import 'package:agile_unify/screens/course/free_courses_screen.dart';
import 'package:agile_unify/screens/edit/edit_screen.dart';
import 'package:agile_unify/screens/home/home_screen.dart';
import 'package:agile_unify/screens/offline/offline_screen.dart';
import 'package:agile_unify/stores/connectivity_store.dart';
import 'package:agile_unify/stores/page_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();

    reaction((_) => pageStore.page,
        (page) => pageController.jumpToPage(page as int));

    autorun((_) {
      if (!connectivityStore.connected) {
        Future.delayed(Duration(milliseconds: 50)).then((value) {
          showDialog(context: context, builder: (_) => OfflineScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          AccessibleCoursesScreen(),
          FreeCoursesScreen(),
          EditScreen(),
        ],
      ),
    );
  }
}
