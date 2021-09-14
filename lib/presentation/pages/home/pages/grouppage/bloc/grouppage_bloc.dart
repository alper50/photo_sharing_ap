import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'grouppage_event.dart';
part 'grouppage_state.dart';

class GrouppageBloc extends Bloc<GrouppageEvent, GrouppageState> {
  GrouppageBloc() : super(GrouppageInitial());
  bool isShowBottomSheet =false;
  @override
  Stream<GrouppageState> mapEventToState(
    GrouppageEvent event,
  ) async* {
    List<bool> toggle = [true, false];
    if(event is ShowInitialPostEvent){
      yield InitialLoading();
      yield await Future.delayed(Duration(seconds: 1),(){
         return ShowPostState();
      });
      
     
    }
    if(event is ShowPostEvent){
      yield Loading();
      isShowBottomSheet=true;
    yield await Future.delayed(Duration(seconds: 1),(){
         return ShowPostState();
      });
      // TODO istek yapılcak
    }
    if(event is ShowMemberEvent){
      yield Loading();
      isShowBottomSheet=false;
      yield await Future.delayed(Duration(seconds: 1),(){
         return ShowMemberState();
      });
       
      //TODO istek lazım
    }
    else{
      //TODO gruba katılma eventi
    }
  }
}
