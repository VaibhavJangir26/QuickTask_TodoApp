import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  var _themeMode = ThemeMode.light;
  ThemeMode get themeMode=> _themeMode;

  void changeTheme(ThemeMode theme){
    _themeMode=theme;
    notifyListeners();
  }


}