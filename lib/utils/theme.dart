import 'package:flutter/material.dart';

ValueNotifier<ThemeMode> temaModu = ValueNotifier(ThemeMode.light);

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.dark,
  ),
);

void toggleTheme() {
  temaModu.value = temaModu.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
}