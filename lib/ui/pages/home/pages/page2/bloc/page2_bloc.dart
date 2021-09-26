import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenlive/core/data/network/post_service.dart';

part 'page2_event.dart';
part 'page2_state.dart';

class Page2Bloc extends Bloc<Page2Event, Page2State> {
  Page2Bloc() : super(Page2Initial());
  List<String> storage = [];
  List<Object> data = [];
  PostApiProvider _repo = PostApiProvider();
  int page = 1;
  int mockdata = 5;
  
  @override
  Stream<Page2State> mapEventToState(
    Page2Event event,
  ) async* {
    if (event is Page2FetchEvent) {
      // TODO backendde grup yapılacak ve grup için get istek oluşturulacak
      yield await Future.delayed(Duration(seconds: 1), () {
        mockdata=mockdata+5;
        return Page2Fetched(hasreachedmax: false,mockdata: mockdata);
      });
    }
    if (event is SearchEvent) {
      print("asfsafsasfasfas");
      yield Loading();
      print(state);
      print(event.inputText);
      //TODO grup için search call yapılacak
      yield await Future.delayed(Duration(seconds: 1), () {
        return Page2Fetched(hasreachedmax: false,mockdata: mockdata);
      });
    }
  }
}
