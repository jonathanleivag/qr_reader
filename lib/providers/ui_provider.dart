import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;
  ThemeMode? theme;
  bool isReady = false;

  UiProvider() {
    _initialTheme();
  }

  int get selectedMenuOpt => _selectedMenuOpt;

  set selectedMenuOpt(int opt) {
    _selectedMenuOpt = opt;
    notifyListeners();
  }

  void changeTheme(ThemeMode typeTheme) {
    theme = typeTheme;
    notifyListeners();
  }

  Future<void> _initialTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('theme') != null) {
      switch (prefs.getString('theme')) {
        case 'light':
          theme = ThemeMode.light;
          break;
        case 'dark':
          theme = ThemeMode.dark;
          break;
        case 'system':
          theme = ThemeMode.system;
          break;
        default:
          theme = ThemeMode.light;
      }
      isReady = true;
      notifyListeners();
    }
  }
}
