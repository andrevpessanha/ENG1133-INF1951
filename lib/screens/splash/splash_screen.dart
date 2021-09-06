import 'package:agile_unify/core/core.dart';
import 'package:agile_unify/screens/base/base_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((_) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BaseScreen()),
        ));
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.linear,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.logo,
            height: 100,
          ),
          SizedBox(height: 40),
          RefreshProgressIndicator(
              semanticsLabel: 'Carregando...',
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation(AppColors.yellow),
              backgroundColor: Color(0xFF222831)),
        ],
      ),
    );
  }
}
