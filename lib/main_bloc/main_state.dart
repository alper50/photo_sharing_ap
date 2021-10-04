part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();
  
  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}
class LanguageChanged extends MainState {
  final Locale selectedLanguage;

  LanguageChanged({this.selectedLanguage});

   @override
  List<Object> get props => [selectedLanguage];
}

class StorageError extends MainState{
  final String error;

  StorageError({this.error});

   @override
   List<Object> get props =>[error];
}
