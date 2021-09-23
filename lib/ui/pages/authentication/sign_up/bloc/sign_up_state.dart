part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpError extends SignUpState {}
class SignUpSucces extends SignUpState {}
class LocationSucces extends SignUpState {}
class LocationLoading extends SignUpState {}
class LocationError extends SignUpState {}
