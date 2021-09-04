import 'package:agile_unify/core/app_colors.dart';
import 'package:agile_unify/models/quiz.dart';
import 'package:agile_unify/screens/quiz/components/next_button.dart';
import 'package:agile_unify/screens/quiz/components/question_indicator.dart';
import 'package:agile_unify/screens/quiz/quiz_controller.dart';
import 'package:agile_unify/screens/result/result_screen.dart';
import 'package:agile_unify/stores/home_store.dart';
import 'package:agile_unify/stores/quiz_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'components/question_screen.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen();

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizStore quizStore = GetIt.I<QuizStore>();
  final HomeStore homeStore = GetIt.I<HomeStore>();
  final controller = QuizController();
  final pageController = PageController();

  @override
  initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page.toInt() + 1;
    });
    super.initState();
  }

  void nextPage() {
    if (controller.currentPage < homeStore.selectedQuiz.questions.length)
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
  }

  void onSelected(bool value) {
    if (value) {
      controller.correctAnswers++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Observer(builder: (_) {
                if (quizStore.error != null || quizStore.loading)
                  return Container();
                return ValueListenableBuilder<int>(
                  valueListenable: controller.currentPageNotifier,
                  builder: (context, value, _) => QuestionIndicator(
                    quizTitle: homeStore.selectedQuiz.title,
                    currentPage: value,
                    length: homeStore.selectedQuiz.questions.length,
                  ),
                );
              })
            ],
          ),
        ),
      ),
      body: SizedBox(
        //height: 600,
        child: Column(
          children: [
            Observer(builder: (_) {
              if (quizStore.error != null) return Container(color: Colors.red);
              if (quizStore.loading)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.purple),
                  ),
                );

              return Container(
                height: 420,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: homeStore.selectedQuiz.questions
                      .map((e) => QuestionScreen(
                            question: e,
                            onSelected: onSelected,
                          ))
                      .toList(),
                ),
              );
            })
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotifier,
            builder: (context, value, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Observer(builder: (_) {
                  if (quizStore.error != null || quizStore.loading)
                    return Container(color: Colors.red);
                  if (value < homeStore.selectedQuiz.questions.length)
                    return Expanded(
                      child: NextButton.purple(
                        label: 'Próxima Questão',
                        onTap: nextPage,
                      ),
                    );

                  if (value == homeStore.selectedQuiz.questions.length)
                    return Expanded(
                      child: NextButton.purple(
                          label: 'Concluir Simulado',
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  title: homeStore.selectedQuiz.title,
                                  length:
                                      homeStore.selectedQuiz.questions.length,
                                  result: controller.correctAnswers,
                                ),
                              ),
                            );
                          }),
                    );
                  return Container();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
