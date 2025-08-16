import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  void toggle() => {
    _mode = _mode == ThemeMode.dark ? ThemeMode.light
        : ThemeMode.dark,
    notifyListeners(),
  };
}