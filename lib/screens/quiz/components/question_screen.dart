import 'package:agile_unify/core/app_text_styles.dart';
import 'package:agile_unify/models/question.dart';
import 'package:agile_unify/screens/quiz/components/answer_check.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({this.question, this.onSelected});

  final Question question;
  final ValueChanged<bool> onSelected;

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int indexSelected = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(widget.question.title, style: AppTextStyles.heading),
          ),
          SizedBox(height: 10),
          for (var i = 0; i < widget.question.answers.length; i++)
            AnswerCheck(
              answer: widget.question.answers[i],
              isRight: widget.question.correctAnswer == i,
              isSelected: indexSelected == i,
              disabled: indexSelected != -1,
              onTap: (value) {
                indexSelected = i;
                setState(() {});
                Future.delayed(Duration(seconds: 1))
                    .then((_) => widget.onSelected(value));
              },
            ),
        ],
      ),
    );
  }
}
