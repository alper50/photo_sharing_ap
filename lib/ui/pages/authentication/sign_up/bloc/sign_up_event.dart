part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpSubmit extends SignUpEvent{
  final String nick;
  final String email;
  final String password;

  SignUpSubmit(this.nick, this.email, this.password);
}
class GetLocation extends SignUpEvent{}