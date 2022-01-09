import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:greenlive/core/data/models/groupmodel.dart';
import 'package:greenlive/core/data/network/group_service.dart';
part 'page2_event.dart';
part 'page2_state.dart';

class Page2Bloc extends Bloc<Page2Event, Page2State> {
  Page2Bloc() : super(Page2Initial());
  List<String> storage = [];
  List<Object> groups = [];
  GroupApiProvider _repo = GroupApiProvider();
  int page = 1;
  int mockdata = 5;

  @override
  Stream<Page2State> mapEventToState(
    Page2Event event,
  ) async* {
    if (state is Page2Initial) {
      yield Page2Loading();
      try {
        await getGroups();
        if (groups.isEmpty) {
          yield Page2Error(error: 'Grup bulunamadı');
        } else {
          page++;
          yield Page2Fetched(hasreachedmax: false, groups: groups as List<GroupModel>?);
        }
      } catch (e) {
         if(e is DioError){
            yield Page2Error(error: 'DİO error');
          }
        yield Page2Error(error: e);
      }
    } else {
      if (state is Page2Fetched) {
        print('adads');
        yield Page2Loading();
        try {
          await getGroups();
          yield Page2Fetched(groups: groups as List<GroupModel>?, hasreachedmax: false);
        } catch (e) {
          if(e is DioError){
            yield Page2Error(error: 'DİO error');
          }
          yield Page2Error(error: e);
        }
      }
    }
    if (event is SearchEvent) {
      yield Page2Loading();
      List<GroupModel> searchedGroups = [];
      searchedGroups = await _repo.searchGroup(text: event.inputText);
      if (searchedGroups.isEmpty) {
        yield Page2SearchNotFound();
      } else {
        yield Page2SearchFound(searchedGroups);
      }

      // yield await Future.delayed(Duration(seconds: 1), () {
      //   return Page2Fetched(hasreachedmax: false, mockdata: mockdata);
      // });
    }
  }

  Future<void> getGroups() async {
    groups += await _repo.getGroups(page, 10);
  }
}
