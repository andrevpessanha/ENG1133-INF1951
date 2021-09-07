import 'package:agile_unify/core/core.dart';
import 'package:agile_unify/models/quiz.dart';
import 'package:agile_unify/screens/home/components/progress_bar.dart';
import 'package:agile_unify/screens/login/login_screen.dart';
import 'package:agile_unify/screens/quiz/quiz_screen.dart';
import 'package:agile_unify/stores/home_store.dart';
import 'package:agile_unify/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class QuizCard extends StatelessWidget {
  const QuizCard(this.quiz, this.index);

  final Quiz quiz;
  final int index;

  @override
  Widget build(BuildContext context) {
    final HomeStore homeStore = GetIt.I<HomeStore>();
    final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

    final imagePath = {
      'PSPO': AppImages.pspo,
      'PSM': AppImages.psm,
      'OKR': AppImages.okr,
      'Product Management': AppImages.pm
    };

    double score = quiz.score * 100;

    return GestureDetector(
      onTap: () {
        if (userManagerStore.isLoggedIn) {
          homeStore.setSelectedQuiz(index);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => QuizScreen()));
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => LoginScreen()));
        }
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: AppColors.border,
          ),
        ),
        color: AppColors.white,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 70.0,
                //width: 100.0,
                child: imagePath != null
                    ? Image.asset(
                        imagePath[quiz.category.title],
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
              SizedBox(height: 14),
              Text(
                quiz.title,
                style: AppTextStyles.heading15,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ProgressBar(value: quiz.score),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Text(score.toStringAsFixed(0) + '%',
                        style: AppTextStyles.body11),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
