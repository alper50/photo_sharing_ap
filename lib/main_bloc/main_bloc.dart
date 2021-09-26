import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:greenlive/core/config/util/l10n/l10n.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial(selectedLanguage: Localizations.localeOf(context)));
  Locale _locale;
  Locale get locale => _locale;

  void setlocale(Locale locale){
    if(!L10n.all.contains(locale)) return;
    _locale=locale;
  }

  @override
  Stream<MainState> mapEventToState(MainEvent event) async*{
    if(event is ChangeLanguage){
      setlocale(event.selectedLanguage);
      yield LanguageChanged(selectedLanguage: _locale);
    }
  }
}