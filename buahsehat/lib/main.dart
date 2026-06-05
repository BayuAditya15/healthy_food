import 'package:flutter/material.dart';
import 'themes/app_theme.dart';
import 'themes/theme_controller.dart';
import 'pages/auth/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeController.isDark,

      builder: (context, isDark, _) {
        return ValueListenableBuilder<Color>(
          valueListenable: ThemeController.primaryColor,

          builder: (context, primary, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              /// LIGHT THEME
              theme: AppTheme.light.copyWith(
                colorScheme: AppTheme.light.colorScheme.copyWith(
                  primary: primary,
                ),
              ),

              /// DARK THEME
              darkTheme: AppTheme.dark.copyWith(
                colorScheme: AppTheme.dark.colorScheme.copyWith(
                  primary: primary,
                ),
              ),

              /// DEFAULT MODE
              themeMode:
                  isDark ? ThemeMode.dark : ThemeMode.light,

              /// FIRST PAGE
              home: const LandingPage(),
            );
          },
        );
      },
    );
  }
}