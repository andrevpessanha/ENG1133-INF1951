import 'package:flutter/material.dart';

import 'package:agile_unify/core/core.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  const ProgressBar({this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: AppColors.chartSecondary,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
    );
  }
}
