import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenlive/core/data/network/post_service.dart';
import 'package:greenlive/core/functions/check_connection.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';

class UserprofileBloc extends Bloc<UserprofileEvent, UserprofileState> {
  UserprofileBloc() : super(UserprofileInitial());

  @override
  Stream<UserprofileState> mapEventToState(
    UserprofileEvent event,
  ) async* {
   CheckConnection connection = CheckConnection();
   if(event is InitialEvent){
     yield Loading();
     String con = await connection.initConnection();
     if (con == "wifi" || con == "mobile") {
       PostApiProvider provider = PostApiProvider();
        List<String> data = [];
        data = await  provider.getUserDetail(event.nickname);
        yield SuccesFetch(data);
      } else {
        yield ConnectionError();
      }
   }
  }
}
