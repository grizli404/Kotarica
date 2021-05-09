import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade800,
    primaryColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    cardColor: Colors.grey.shade800,
    accentColor: Colors.white,
    hintColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.grey.shade900,
    cardTheme: CardTheme(color: Colors.black),
    indicatorColor: Colors.black,
    bottomAppBarColor: Colors.white,
    canvasColor: Colors.white,
    hoverColor: Colors.grey.shade800,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: kBackgroundColor,
    primaryColor: kPrimaryColor,
    colorScheme: ColorScheme.light(),
    cardColor: Colors.white,
    cardTheme: CardTheme(color: Colors.white),
    accentColor: kPrimaryColor,
    hintColor: Color(0xFF575E67),
    iconTheme: IconThemeData(color: kPrimaryColor),
    dividerColor: kPrimaryColor,
    indicatorColor: kPrimaryColor,
    bottomAppBarColor: Colors.white,
    canvasColor: Colors.white,
    hoverColor: Color(0xFF6580ad),
  );
}
