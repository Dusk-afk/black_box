import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    _load();
  }

  ThemeMode? _themeMode;

  ThemeMode? get themeMode => _themeMode;
  set themeMode(ThemeMode? mode) {
    _themeMode = mode;
    notifyListeners();
    _save();
  }

  void _load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? theme = prefs.getString('theme');
    if (theme == 'ThemeMode.system') {
      _themeMode = ThemeMode.system;
    } else if (theme == 'ThemeMode.light') {
      _themeMode = ThemeMode.light;
    } else if (theme == 'ThemeMode.dark') {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  void _save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', _themeMode.toString());
  }
}
