part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();
  
  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {
   final Locale selectedLanguage;

  MainInitial({this.selectedLanguage});

   @override
  List<Object> get props => [selectedLanguage];
}
class LanguageChanged extends MainState {
  final Locale selectedLanguage;

  LanguageChanged({this.selectedLanguage});

   @override
  List<Object> get props => [selectedLanguage];
}