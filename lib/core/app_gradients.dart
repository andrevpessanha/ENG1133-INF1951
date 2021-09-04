import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradients {
  static final linear = LinearGradient(
    colors: [Color(0xFF784CFB), Color.fromRGBO(117, 91, 255, 0.695)],
    stops: [0.0, 0.695],
    transform: GradientRotation(2.13959913 * pi),
  );
}
