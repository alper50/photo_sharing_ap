import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenlive/core/functions/check_connection.dart';

part 'homebase_event.dart';
part 'homebase_state.dart';

class HomebaseBloc extends Bloc<HomebaseEvent, HomebaseState> {
  HomebaseBloc() : super(HomebaseInitial());

  @override
  Stream<HomebaseState> mapEventToState(
    HomebaseEvent event,
  ) async* {
    CheckConnection connection = CheckConnection();
    if (event is HomeInitialEvent) {
      yield Loading();
      String con = await connection.initConnection();
      if (con == "wifi" || con == "mobile") {
        yield ConnectionFound();
      } else {
        yield ConnectionError();
      }
    } else if (event is RefreshConnectionEvent) {
      yield Loading();
      String con = await connection.initConnection();
      if (con == "wifi" || con == "mobile") {
        yield ConnectionFound();
      } else {
        yield ConnectionError();
      }
    }
  }
}
