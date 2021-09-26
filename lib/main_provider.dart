import 'package:flutter/material.dart';
import 'package:greenlive/core/config/util/l10n/l10n.dart';

class MainProvider extends ChangeNotifier{

  Locale _locale;
  Locale get locale => _locale;

  void setlocale(Locale locale){
    if(!L10n.all.contains(locale)) return;
    _locale=locale;
    notifyListeners();
  }
}