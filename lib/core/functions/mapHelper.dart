import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper {
  static Set<Marker> markers = {};

  static void onmapcreated() {
    markers.add(
      Marker(
        markerId: MarkerId("deneme"),
        position: LatLng(58.9637, 80.2433),
      ),
    );
  }
}
