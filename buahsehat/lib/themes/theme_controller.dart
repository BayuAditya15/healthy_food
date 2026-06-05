import 'package:flutter/material.dart';

class ThemeController {
  /// DEFAULT LIGHT MODE
  static ValueNotifier<bool> isDark = ValueNotifier(false);

  /// PRIMARY COLOR
  static ValueNotifier<Color> primaryColor = ValueNotifier(Colors.green);

  /// TOGGLE DARK/LIGHT
  static void toggleTheme() {
    isDark.value = !isDark.value;
  }

  /// CHANGE PRIMARY COLOR
  static void changePrimary(Color color) {
    primaryColor.value = color;
  }
}
