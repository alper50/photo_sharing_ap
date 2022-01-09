part of 'page1_bloc.dart';

abstract class Page1Event extends Equatable {
  const Page1Event();

  @override
  List<Object?> get props => [];
}
class InitialEvent extends Page1Event{}
class Page1FetchEvent extends Page1Event{
  final String? category;

  Page1FetchEvent({this.category});
  List<Object?> get props => [category];
}
class FilterEvent extends Page1Event{
  final String category;
  final bool selected;
  FilterEvent(this.category, this.selected);
  List<Object> get props => [category,selected];
}