import 'package:agile_unify/repositories/server_keys.dart';
import 'package:agile_unify/screens/splash/splash_screen.dart';
import 'package:agile_unify/stores/category_store.dart';
import 'package:agile_unify/stores/connectivity_store.dart';
import 'package:agile_unify/stores/course_store.dart';
import 'package:agile_unify/stores/home_store.dart';
import 'package:agile_unify/stores/page_store.dart';
import 'package:agile_unify/stores/quiz_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'core/app_colors.dart';

void main() async {
  await initializeParse();
  setupLocators();
  runApp(MyApp());
}

void setupLocators() {
  GetIt.I.registerSingleton(ConnectivityStore());
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
  GetIt.I.registerSingleton(HomeStore());
  GetIt.I.registerSingleton(QuizStore());
  GetIt.I.registerSingleton(CourseStore());
}

Future<void> initializeParse() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true, debug: true);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agile Unify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: AppColors.purple),
      ),
      home: SplashScreen(),
    );
  }
}
