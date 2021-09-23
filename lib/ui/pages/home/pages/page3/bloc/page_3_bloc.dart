import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenlive/core/functions/mapHelper.dart';

part 'page_3_event.dart';
part 'page_3_state.dart';

class Page3Bloc extends Bloc<Page3Event, Page3State> {
  Page3Bloc() : super(Page3Initial());

  @override
  Stream<Page3State> mapEventToState(
    Page3Event event,
  ) async* {
    if (event is InitialEvent) {
      yield PageLoading();
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
