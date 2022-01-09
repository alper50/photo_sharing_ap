part of 'page2_bloc.dart';

abstract class Page2Event extends Equatable {
  const Page2Event();

  @override
  List<Object?> get props => [];
}
class Page2FetchEvent extends Page2Event{}

 


class SearchEvent extends Page2Event{
  final String? inputText;

  SearchEvent({this.inputText});
  List<Object?> get props => [inputText];
  
  }
