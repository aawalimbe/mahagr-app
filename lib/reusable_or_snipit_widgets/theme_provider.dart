import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  
  // Pages that should always use light theme
  static const List<String> _excludedPages = [
    'login',
    'registration', 
    'forgot_password',
  ];
  
  ThemeProvider() {
    _loadTheme();
  }
  
  // Load theme preference from SharedPreferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool(_themeKey) ?? false;
      notifyListeners();
    } catch (e) {
      print('Error loading theme: $e');
      _isDarkMode = false;
    }
  }
  
  // Save theme preference to SharedPreferences
  Future<void> _saveTheme(bool isDark) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, isDark);
    } catch (e) {
      print('Error saving theme: $e');
    }
  }
  
  // Toggle theme
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _saveTheme(_isDarkMode);
    notifyListeners();
  }
  
  // Set specific theme
  Future<void> setTheme(bool isDark) async {
    _isDarkMode = isDark;
    await _saveTheme(_isDarkMode);
    notifyListeners();
  }
  
  // Check if current page should use light theme
  bool shouldUseLightTheme(String pageName) {
    return _excludedPages.contains(pageName.toLowerCase());
  }
  
  // Get theme data for MaterialApp
  ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textOnDark,
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.textOnLight),
        bodyMedium: TextStyle(color: AppColors.textOnLight),
        bodySmall: TextStyle(color: AppColors.secondaryText),
      ),
      checkboxTheme: CheckboxThemeData(shape: CircleBorder()),
    );
  }
  
  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.darkPrimaryColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurfaceColor,
        foregroundColor: AppColors.darkTextPrimaryColor,
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkTextPrimaryColor),
        bodyMedium: TextStyle(color: AppColors.darkTextPrimaryColor),
        bodySmall: TextStyle(color: AppColors.darkTextSecondaryColor),
      ),
      checkboxTheme: CheckboxThemeData(shape: CircleBorder()),
    );
  }
  
  // Get current theme data
  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;
}
