import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF63D31A); // Green from logo/UI
  static const Color secondary = Color(0xFF86E129); // Lighter green for gradient
  static const Color background = Colors.white;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;
  static const Color surface = Color(0xFFF5F5F5);
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color facebookBlue = Color(0xFF1877F2); // Not used per requirements, but good for reference
  
  static const Gradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
