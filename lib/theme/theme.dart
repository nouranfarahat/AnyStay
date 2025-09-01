import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF0B393D); // Deep Navy Blue
  static const Color secondaryColor = Color(0xFFB7EEE9); // Forest Green
  static const Color accentColor = Color(0xFFE07A5F); // Warm Coral
  static const Color backgroundColor = Color(0xFFF8F9FA); // Off-White
  static const Color surfaceColor = Color(0xFFFFFFFF); // White
  static const Color textColor = Color(0xFF212529); // Charcoal
  static const Color textSecondaryColor = Color(0xFF6C757D); // Medium Grey
  static  Color cardShadowColor = Colors.black54.withOpacity(0.1); // Medium Grey

// Text Sizes - Create a consistent scale
  static const double fontSizeDisplayLarge = 32.0;
  static const double fontSizeDisplayMedium = 28.0;
  static const double fontSizeDisplaySmall = 24.0;
  static const double fontSizeHeadlineMedium = 20.0;
  static const double fontSizeHeadlineSmall = 18.0;
  static const double fontSizeTitleLarge = 16.0;
  static const double fontSizeBodyLarge = 16.0;
  static const double fontSizeBodyMedium = 14.0;
  static const double fontSizeBodySmall = 12.0;
  static const double fontSizeLabelLarge = 14.0;
  static const double fontSizeLabelSmall = 11.0;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
      ),
      scaffoldBackgroundColor: backgroundColor,

      // Text Theme with consistent sizes
      textTheme: const TextTheme(
        // Display - Largest text (for major headlines)
        displayLarge: TextStyle(
          fontSize: fontSizeDisplayLarge,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        displayMedium: TextStyle(
          fontSize: fontSizeDisplayMedium,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        displaySmall: TextStyle(
          fontSize: fontSizeDisplaySmall,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),

        // Headline - For section titles
        headlineMedium: TextStyle(
          fontSize: fontSizeHeadlineMedium,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        headlineSmall: TextStyle(
          fontSize: fontSizeHeadlineSmall,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),

        // Title - For card titles, buttons
        titleLarge: TextStyle(
          fontSize: fontSizeTitleLarge,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),

        // Body - For regular text content
        bodyLarge: TextStyle(
          fontSize: fontSizeBodyLarge,
          color: textColor,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: fontSizeBodyMedium,
          color: textSecondaryColor,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: fontSizeBodySmall,
          color: secondaryColor,
          fontWeight: FontWeight.w600
        ),

        // Label - For form labels, captions
        labelLarge: TextStyle(
          fontSize: fontSizeLabelLarge,
          fontWeight: FontWeight.w500,
          color: Colors.white, // For buttons
        ),
        labelSmall: TextStyle(
          fontSize: fontSizeLabelSmall,
          color: textSecondaryColor,
        ),
      ),

      // Other theme properties...
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: fontSizeLabelLarge,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}