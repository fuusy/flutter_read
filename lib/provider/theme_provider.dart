import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/db/sp_cache.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode? _themeMode;

  bool isDark(){
    return _themeMode == ThemeMode.dark;
  }

  ThemeMode? getThemeMode() {
    var  theme = FCache.getInstance()!.get("key");
    switch (theme) {
      case "Dark":
        _themeMode = ThemeMode.dark;
        break;
      case "Light":
        _themeMode = ThemeMode.light;
        break;
      case "System":
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }

    return _themeMode;
  }

  void setThemeMode(String mode) {
    FCache.getInstance()!.setString("key", mode);
    notifyListeners();
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: isDarkMode ? Colors.black : Colors.white,
        accentColor: isDarkMode ? Colors.black26 : Colors.white,
        scaffoldBackgroundColor: isDarkMode ? Colors.black : Colors.white);
    return themeData;
  }
}
