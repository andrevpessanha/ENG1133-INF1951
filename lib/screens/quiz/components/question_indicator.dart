import 'package:agile_unify/core/app_text_styles.dart';
import 'package:agile_unify/screens/home/components/progress_bar.dart';
import 'package:flutter/material.dart';

class QuestionIndicator extends StatelessWidget {
  final String quizTitle;
  final int currentPage;
  final int length;

  const QuestionIndicator({
    this.quizTitle,
    this.currentPage,
    this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$quizTitle', style: AppTextStyles.body),
              Text('$currentPage / $length', style: AppTextStyles.body),
            ],
          ),
          SizedBox(height: 16),
          ProgressBar(value: currentPage / length),
        ],
      ),
    );
  }
}
