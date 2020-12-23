import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagaddod/podo/request.dart';

abstract class LocationState {}

class LocationsAre extends LocationState {
  Set<Marker> markers;
  LocationsAre(this.markers);
}

class SelectedRequestIs extends LocationState {
  Request request;
  SelectedRequestIs(this.request);
}

class RemainingRequestsAre extends LocationState {
  List<Request> requests;
  RemainingRequestsAre(this.requests);
}

class CurrentLocationIs extends LocationState {
  LatLng currentLocation;
  CurrentLocationIs(this.currentLocation);
}

class MyLocationIs extends LocationState{
  Marker myLocation;
  MyLocationIs(this.myLocation);
}

class SubCancelled extends LocationState{
  
}
