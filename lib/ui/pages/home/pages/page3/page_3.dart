import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenlive/core/config/storage/storage.dart';
import 'package:greenlive/core/data/models/markermodel.dart';
import 'package:greenlive/core/data/network/post_service.dart';
import 'package:greenlive/core/data/repository/post_repo.dart';
import 'package:greenlive/ui/pages/home/bloc/homebase_bloc.dart';
import 'package:greenlive/ui/pages/home/pages/page3/bloc/page_3_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  PostRepository repo = PostRepository();
  List<MarkerModel> data = [];
  GoogleMapController controller;
  List<String> storage =[];
  BitmapDescriptor icon;

  @override
  void initState() {
    super.initState();
    initfect();
  }

  Future<void> initfect() async {
     storage = await Storage.getStringList("location");
    PostApiProvider _repo = PostApiProvider();
    data = await _repo.getMarkers(71.75590000,42.13650000);
    print("DATTTTA  $data");
    if (!data.isNotEmpty) {
      controller
          .animateCamera(CameraUpdate.newLatLng(data.first.markerlatlong));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Orada hiç paylaşım bulamadık"),));
    }
  }

  Future<void> requestPermission() async {
    await Permission.location.request();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    return BlocProvider(
      create: (context) => Page3Bloc()..add(InitialEvent()),
      child: BlocConsumer<Page3Bloc, Page3State>(
        listener: (context, state) {
          if (state is LocationSettingClosed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Text("Konum kapalı"),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<Page3Bloc>(context).add(OpenSettings());
                    },
                    child: Text("Konumu Aç"),
                  ),
                ],
              ),
            ));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return CircularProgressIndicator();
          } else {
            return SafeArea(
              child: Scaffold(
                body: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: storage.isNotEmpty?  LatLng(double.parse(storage[0]), double.parse(storage[1])): LatLng(12.00000,15.00000),
                    zoom: 15,
                  ),
                  onMapCreated: (map) async{
                    controller = map;
                    await createicon(context);
                  },
                  markers: createMarker(),

                ),
              ),
            );
          }
        },
      ),
    );
  }

  Set<Marker> createMarker() {
    return data
        .map(
          (e) => Marker(
            icon:icon,
            markerId: MarkerId(e.hashCode.toString()),
            position: e.markerlatlong,
            zIndex: 10,
            draggable: false,
            infoWindow: InfoWindow(title: e.category),
          ),
        )
        .toSet();
  }

  Future<void> createicon(BuildContext context)async{
    final ImageConfiguration imageConfiguration = createLocalImageConfiguration(context);
    var bitmap = await BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/water.png');
    icon=bitmap;
    setState(() {});
  }
}
