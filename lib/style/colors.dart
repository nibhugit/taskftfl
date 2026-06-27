import 'package:flutter/material.dart';

class AppColors {
  /*-- Basic Colors ------------------------------------*/
  static const Color primary = Color(0xFFEF1A32);
  static const Color primaryLight = Color(0xFF7C63FF);
  static const Color primaryDark = Color(0xFF7A4418);

  static const Color error = Color(0xFFFF3F40);
  static const Color success = Color(0xFF2ECC71);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFF805340);
  static const Color creamBackground = Color(0xFFFAF6F0);

  /*-- Text Colors ------------------------------------*/
  static const Color textPrimary = Color(0xFF19204C);
  static const Color textSecondary = Color(0xFF4C2625);
  static const Color color212121 = Color(0xFF212121);

  static const gradiant = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.1, 0.5, 0.7, 0.9],
    colors: [Color(0xFF805340), Color(0xFF5E402B)],
  );
}
