
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:greenlive/core/config/storage/storage.dart';
import 'package:greenlive/core/config/util/l10n/l10n.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(LanguageChanged(selectedLanguage: Locale('en')));
  Locale? _locale = Locale('en');
  Locale? get locale => _locale;

  void setlocale(Locale? locale){
    if(!L10n.all.contains(locale)) return;
    _locale=locale;
  }
  Future<String?> getStorageLocale()async{
    String? localeLanguage = await Storage.getString('language');
    return localeLanguage;
  }
  @override
  Stream<MainState> mapEventToState(MainEvent event) async*{
    if(event is GetStorageLanguage){
      String? localLanguage = await getStorageLocale();
      if(localLanguage==''){
        yield LanguageChanged(selectedLanguage: Locale('en')); 
      }else{
        yield LanguageChanged(selectedLanguage: Locale('$localLanguage'));
      }
    }
    if(event is ChangeLanguage){
      setlocale(event.selectedLanguage);
      Storage.setString('language', '${event.selectedLanguage!.languageCode}');
      yield LanguageChanged(selectedLanguage: _locale);
    }
  }
}