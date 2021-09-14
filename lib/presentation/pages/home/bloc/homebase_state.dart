part of 'homebase_bloc.dart';

abstract class HomebaseState extends Equatable {
  const HomebaseState();
  
  @override
  List<Object> get props => [];
}

class HomebaseInitial extends HomebaseState {}
class Loading extends HomebaseState {}
class ConnectionFound extends HomebaseState {}
class ConnectionError extends HomebaseState {}
