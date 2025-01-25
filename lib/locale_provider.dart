import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Default to English

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners(); // Notify the app about the locale change
    }
  }

  void clearLocale() {
    _locale = const Locale('en'); // Reset to default
    notifyListeners();
  }
}
