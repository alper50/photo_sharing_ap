part of 'page2_bloc.dart';

abstract class Page2State extends Equatable {
  const Page2State();
  
  @override
  List<Object> get props => [];
}

class Page2Initial extends Page2State {}
class Loading extends Page2State {}
class Fetched extends Page2State {}