import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences prefs;
  static const String _themeKey = 'theme_mode';

  ThemeCubit(this.prefs) : super(_loadTheme(prefs));

  static ThemeMode _loadTheme(SharedPreferences prefs) {
    final themeStr = prefs.getString(_themeKey);
    if (themeStr == 'dark') return ThemeMode.dark;
    if (themeStr == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }

  void toggleTheme() {
    final nextMode =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    prefs.setString(_themeKey, nextMode == ThemeMode.dark ? 'dark' : 'light');
    emit(nextMode);
  }
}
