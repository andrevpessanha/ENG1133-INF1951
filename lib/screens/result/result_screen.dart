import 'package:agile_unify/screens/base/base_screen.dart';
import 'package:agile_unify/screens/quiz/components/next_button.dart';
import 'package:agile_unify/stores/home_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:agile_unify/core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultScreen extends StatefulWidget {
  final String title;
  final int length;
  final int result;

  const ResultScreen({this.title, this.length, this.result});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final HomeStore homeStore = GetIt.I<HomeStore>();

  @override
  void initState() {
    super.initState();
    //homeStore.incrementQtdCompleted();
    //userManagerStore.incrementQtdCompletedQuizzes();
    print('RESULT: ' + widget.result.toString());
    print('LENGTH: ' + widget.result.toString());
    final score = widget.result / widget.length;
    print('NEW SCORE: ' + score.toStringAsFixed(2));
    print('OLD SCORE: ' + homeStore.selectedQuiz.score.toStringAsFixed(2));
    if (score > homeStore.selectedQuiz.score) {
      homeStore.updateQuizScore(score);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.trophy),
            Column(
              children: [
                Text(
                  'Parabéns!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading40,
                ),
                SizedBox(height: 16),
                Text.rich(
                  TextSpan(
                    text: 'Você concluiu o Simulado',
                    style: AppTextStyles.body,
                    children: [
                      TextSpan(
                        text: '\n${widget.title}',
                        style: AppTextStyles.bodyBold,
                      ),
                      TextSpan(
                        text:
                            '\nPontuação: ${widget.result} / ${widget.length} acertos.',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 68),
                        child: NextButton.purple(
                          label: 'Materiais Gratuitos',
                          onTap: () {
                            launch("https://andrevpessanha.com");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 68),
                        child: NextButton.white(
                            label: 'Ver Simulados',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BaseScreen()),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
