import 'package:flutter/material.dart';

class AppState {
  ThemeMode currentTheme = ThemeMode.light;


  AppState({ required this.currentTheme });

  AppState copyWith({ ThemeMode? newTheme }) {
    return AppState(
      currentTheme: newTheme ?? currentTheme
    );
  }
}
