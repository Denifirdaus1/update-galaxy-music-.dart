import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = true;
  
  bool get isDarkMode => _isDarkMode;
  
  ThemeData get theme => _isDarkMode ? darkTheme : lightTheme;
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
  
  // Dark theme
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.white,
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[800],
    ),
    cardColor: Colors.grey[850],
    colorScheme: ColorScheme.dark(
      surface: Colors.grey[850]!,
      primary: Colors.white,
      secondary: Colors.grey[700]!,
    ),
  );
  
  // Light theme
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[200],
    ),
    cardColor: Colors.grey[100],
    colorScheme: ColorScheme.light(
      surface: Colors.grey[100]!,
      primary: Colors.black,
      secondary: Colors.grey[300]!,
    ),
  );
}
