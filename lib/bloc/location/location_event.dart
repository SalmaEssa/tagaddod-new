import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagaddod/podo/request.dart';

abstract class LocationEvent{}

class LocationsRequested extends LocationEvent{}

class MarkerUpdated extends LocationEvent{
  Set<Marker> markers;
  Request request;
  MarkerUpdated({this.markers,this.request});
}

class CancelSub extends LocationEvent{}