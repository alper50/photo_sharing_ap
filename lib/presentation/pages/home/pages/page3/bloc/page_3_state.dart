part of 'page_3_bloc.dart';

// ignore: camel_case_types
abstract class Page3State extends Equatable {
  const Page3State();
  
  @override
  List<Object> get props => [];
}

class Page3Initial extends Page3State {}
class PageLoading extends Page3State {}
class InitialMarkerFetch extends Page3State {
  final Set<Marker> marker;

  InitialMarkerFetch(this.marker);
  @override
  List<Object> get props => [marker];

} // markerlar sunucudan geldi demek
class LocationNotFound extends Page3State {}
class LocationSearching extends Page3State {}
class LocationSettingClosed extends Page3State {}