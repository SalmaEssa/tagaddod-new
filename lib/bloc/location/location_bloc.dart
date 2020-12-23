import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tagaddod/bloc/bloc.dart';
import 'package:tagaddod/bloc/location/location_event.dart';
import 'package:tagaddod/bloc/location/location_state.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/podo/regionRequest.dart';
import 'package:tagaddod/podo/request.dart';
import 'package:tagaddod/services/home.dart';
import 'package:tagaddod/services/request.dart';
import 'package:tagaddod/support/Maps/MapHelper.dart';
import 'package:location/location.dart';

class LocationBloc extends BLoC<LocationEvent> {
  final PublishSubject<LocationState> locationStateSubject = PublishSubject();
  MapHelper _mapHelper = MapHelper();
  HomeService _homeService = GetIt.instance<HomeService>();
  Location location = new Location();
  RequestService _requestService = GetIt.instance<RequestService>();

  bool _serviceEnabled;
  bool _serviceGranted = true;
  PermissionStatus _permissionGranted = PermissionStatus.granted;
  PermissionStatus _hasPermission;
  Marker myLocation;

  @override
  void dispatch(LocationEvent event) async {
    if (event is LocationsRequested) {
      await getMyLocation();
      await getLocations();
    }

    if(event is CancelSub){
      locationStateSubject.sink.add(SubCancelled());
    }
  }

  Future<void> getMyLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceGranted = await location.requestService();
    }
    if (!_serviceGranted) {
      return;
    }

    _hasPermission = await location.hasPermission();
    if (_hasPermission == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }

    myLocation = await _requestService.getMyLocation();
    locationStateSubject.sink.add(MyLocationIs(myLocation));
  }

  Future<void> getLocations() async {
    Set<Marker> markers = {};
    markers.add(myLocation);
    Collector collector = await _homeService.getRegionsRequests();
    List<RegionRequest> regionRequests = collector.regions_requests;
    List<Request> requests = [];
    for (var regionRequest in regionRequests) {
      requests.addAll(regionRequest.requests);
    }

    LatLng _currentLocationLatLng = _requestService.getCenter(requests);
    locationStateSubject.sink.add(CurrentLocationIs(_currentLocationLatLng));
    locationStateSubject.sink.add(RemainingRequestsAre(requests));
    print("Hello from the bloc");
  }

  dispose() {
    locationStateSubject.close();
  }
}
