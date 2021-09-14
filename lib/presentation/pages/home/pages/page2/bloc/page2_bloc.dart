import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page2_event.dart';
part 'page2_state.dart';

class Page2Bloc extends Bloc<Page2Event, Page2State> {
  Page2Bloc() : super(Page2Initial());

  @override
  Stream<Page2State> mapEventToState(
    Page2Event event,
  ) async* {
    if(state is Page2Initial){
      // TODO backendde grup yapılacak ve grup için get istek oluşturulacak
      yield await Future.delayed(Duration(seconds: 1),(){
        return Fetched();
      });
    }
    if(state is Fetched){
      print("asfsafsasfasfas");
      
    }
    if(event is SearchEvent){
        
        yield Loading();
        print(state);
        print(event.inputText);
        //TODO grup için search call yapılacak
        yield await Future.delayed(Duration(seconds: 1),(){
        return Fetched();
      });
      }
  }
}
