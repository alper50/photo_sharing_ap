import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenlive/core/config/storage/storage.dart';
import 'package:greenlive/core/data/models/markermodel.dart';
import 'package:greenlive/core/data/network/post_service.dart';
import 'package:greenlive/core/functions/mapHelper.dart';

part 'page_3_event.dart';
part 'page_3_state.dart';

class Page3Bloc extends Bloc<Page3Event, Page3State> {
  Page3Bloc() : super(Page3Initial());
  List<MarkerModel>? data = [];
  List<String> storage =[];
  double? initialLat;
  double? initialLong;
  PostApiProvider _repo = PostApiProvider();
  @override
  Stream<Page3State> mapEventToState(
    Page3Event event,
  ) async* {
    if (event is InitialEvent) {
      yield PageLoading();
      storage = await Storage.getStringList("location");
      initialLat = double.parse(storage[0]);
      initialLong = double.parse(storage[1]);
       data = await _repo.getMarkers(initialLat,initialLong);
      Future.delayed(Duration(seconds: 2), () async* {
        MapHelper.onmapcreated();
        yield Future.delayed(Duration(seconds: 1),(){
          return InitialMarkerFetch(MapHelper.markers);
        });
      });
    }
    if (event is FindLocation) {
      yield LocationSearching();
      bool isserviceenabled = await Geolocator.isLocationServiceEnabled();
      if (isserviceenabled == false) {
        yield LocationSettingClosed();
      }
    }
    if (event is OpenSettings) {
      Geolocator.openLocationSettings();
    }
  }
}
