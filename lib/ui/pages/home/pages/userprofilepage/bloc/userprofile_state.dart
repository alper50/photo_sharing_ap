part of 'userprofile_bloc.dart';

abstract class UserprofileState extends Equatable {
  const UserprofileState();
  
  @override
  List<Object?> get props => [];
}

class UserprofileInitial extends UserprofileState {}
class Loading extends UserprofileState {}
class ConnectionError extends UserprofileState {}
class SuccesFetch extends UserprofileState {
  final List<String>? data;

  SuccesFetch(this.data);
  @override
  List<Object?> get props => [data];
}
class EmptyFetch extends UserprofileState {}
class ErrorFetch extends UserprofileState {}