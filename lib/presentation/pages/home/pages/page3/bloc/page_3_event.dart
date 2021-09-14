part of 'page_3_bloc.dart';

// ignore: camel_case_types
abstract class Page3Event extends Equatable {
  const Page3Event();

  @override
  List<Object> get props => [];
}
class InitialEvent extends Page3Event{}
class FindLocation extends Page3Event{}
class OpenSettings extends Page3Event{}
class MapCreated extends Page3Event{}