import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greenlive/core/config/storage/storage.dart';
import 'package:greenlive/core/data/repository/auth_repo.dart';
import 'package:greenlive/core/functions/tokenhelper.dart';
import 'package:permission_handler/permission_handler.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthRepository authrepo = AuthRepository();
  bool issignup =false;
  bool islocationbuttonpressed = false;
  Position location;
  TokenHelper tokenHelper = TokenHelper();
  String token;
  AuthRepository provider = AuthRepository();
  SignUpBloc() : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUpSubmit) {
      yield SignUpLoading();
      if (true) {
        token = await tokenHelper.createToken();
        try {
          provider.signUp(event.nick, event.email, event.password, token);
        } catch (e) {
          print("${e.toString()}");
          yield SignUpError();
        }
      }
      if (issignup) {
        await Storage.setBool("logged", true);
        yield SignUpSucces();
      } else {
        await Storage.setBool("logged", true);
        yield SignUpError();
      }
    } else if(event is GetLocation) {
      yield LocationLoading();
      PermissionStatus permission = await Permission.location.request();
      // ignore: unrelated_type_equality_checks
      if (permission.isGranted == true) {
        bool isgpsopen = await Geolocator.isLocationServiceEnabled();
        if (!isgpsopen) {
          await Geolocator.openLocationSettings();
        }
        location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        List<String> list = ["${location.latitude}", "${location.longitude}"];
        bool setlocal = await Storage.setStringList("location", list);
        if (setlocal == true) {
          islocationbuttonpressed = true;
          yield LocationSucces();
        } else {
          yield LocationError();
        }
      } else {
        yield LocationError();
      }
    }
  }
}
