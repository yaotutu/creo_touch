import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme(Color primaryColor) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      surface: Colors.black,
    );

    return ThemeData.dark().copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 26, // 标题字体放大
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 38, // 主标题更大
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        displayMedium: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        headlineLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(
          fontSize: 20, // 正文字体放大
          color: colorScheme.onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 18,
          color: colorScheme.onSurface,
        ),
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        labelMedium: TextStyle(
          fontSize: 16,
          color: colorScheme.onSurface.withAlpha(204),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(80, 80), // 按钮更大
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: const TextStyle(
            fontSize: 20, // 按钮文字加大
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.grey[800], // 稍微深一点，更暗
        margin: const EdgeInsets.all(16), // 卡片间距更大
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // 圆角加大
        ),
        elevation: 6, // 提升阴影
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[900],
        contentTextStyle: TextStyle(
          fontSize: 18, // 文字加大
          color: colorScheme.onSurface,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 圆角加大
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: Colors.grey[700],
        circularTrackColor: Colors.grey[800],
        linearMinHeight: 6, // 线性进度条高度加粗
      ),
    );
  }
}
