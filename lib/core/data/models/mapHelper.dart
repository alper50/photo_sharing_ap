import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper {
  static Set<Marker> markers = {};

  static void onmapcreated() {
    markers.add(
      Marker(
        markerId: MarkerId("deneme"),
        position: LatLng(38.9637, 35.2433),
      ),
    );
  }
}
