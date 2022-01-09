part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}
class LoginEvent extends SignInEvent{
  final String? nickname;
  final String? password;

  LoginEvent({this.nickname, this.password});

  List<Object?> get props => [nickname,password];
}

class TryAgainEvent extends SignInEvent{}