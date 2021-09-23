import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenlive/ui/pages/home/bloc/homebase_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if(event is LoginEvent){
      yield SignInLoading();
      yield await Future.delayed(Duration(seconds: 1),(){
        return SignInSucces();
      });
    }
    if(event is TryAgainEvent){
      yield SignInInitial();
    }
  }
}
