import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagaddod/bloc/location/location_bloc.dart';
import 'package:tagaddod/bloc/location/location_event.dart';
import 'package:tagaddod/bloc/location/location_state.dart';
import 'package:tagaddod/bloc/request/bloc.dart';
import 'package:tagaddod/main_route.dart';
import 'package:tagaddod/podo/request.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/support/Maps/MapHelper.dart';
import 'package:tagaddod/ui/request/done_dialoug.dart';
import 'package:tagaddod/ui/request/sliding_panel.dart';
import 'package:tagaddod/ui/shared_widgets/common_headers.dart';
import 'package:tagaddod/ui/shared_widgets/response_toast.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  StreamSubscription locationSub;
  LatLng _currentLocationLatLng = LatLng(30.167290894176734, 31.56698068523754);
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  GoogleMapController _mapController;
  double _zoom = 8.0;
  LocationBloc locationBloc = GetIt.instance<LocationBloc>();
  Request selectedRequest;
  List<Request> remainigRequests = [];
  RequestBloc _requestBloc = GetIt.instance<RequestBloc>();
  StreamSubscription requestSub;
  bool visible = false;
  Timer errorTimer;
  bool requestsLoading = true;
  MapHelper _mapHelper = MapHelper();
  Marker myLocation;

  @override
  void initState() {
    locationSub = locationBloc.locationStateSubject.listen((state) {
      if (state is SelectedRequestIs) {
        setState(() {
          selectedRequest = state.request;
        });

        _requestBloc.dispatch(SetSelectedRequest(state.request));
      }
      if (state is RemainingRequestsAre) {
        setState(() {
          remainigRequests = state.requests;
          _buildMarkers();
          requestsLoading = false;
        });
        if (state.requests.length == 0) {
          print("Hello from the UI");
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) {
                return DoneDialog();
              });
        }
      }
      if (state is CurrentLocationIs) {
        setState(() {
          _currentLocationLatLng = state.currentLocation;
        });
      }
      if (state is MyLocationIs) {
        setState(() {
          myLocation = state.myLocation;
        });
      }
      if (state is SubCancelled) {
        locationSub.cancel();
        requestSub.cancel();
        return;
      }
    });
    locationBloc.dispatch(LocationsRequested());

    requestSub = _requestBloc.requestStateSubject.listen((state) {
      if (state is ComplainStatusIs) {
        if (state.status) {
          locationBloc.dispatch(LocationsRequested());
          _requestBloc.dispatch(UpdateComplainStatus(false));
          setState(() {
            visible = true;
          });
          errorTimer = Timer.periodic(Duration(seconds: 5), (timer) {
            setState(() {
              visible = false;
              errorTimer.cancel();
              errorTimer = null;
            });
          });
        }
      }
    });

    _requestBloc.dispatch(GetComplainStatus());
    super.initState();
  }

  Future<void> _buildMarkers() async {
    Set<Marker> markers = {};
    markers.add(myLocation);
    for (var request in remainigRequests) {
      Marker marker = await _mapHelper.getMarker(
        LatLng(
          double.parse(request.address.latitude),
          double.parse(request.address.longitude),
        ),
        request == selectedRequest
            ? AssetStrings.pickupLocationSelected
            : AssetStrings.pickupLocation,
        remainigRequests.indexOf(request).toString(),
        () {
          print("Marker Tapped");

          setState(() {
            selectedRequest = request;
          });
          _buildMarkers();
          _requestBloc.dispatch(SetSelectedRequest(request));
        },
      );

      markers.add(marker);
    }
    setState(() {
      _markers = {};
      _markers.addAll(markers);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    locationSub.cancel();
    requestSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMap(),
          TitleHeader(
            child: _buildHeaderChild(),
          ),
          PositionedDirectional(
            child: _buildRefreshButton(),
            start: 15,
            top: 150,
          ),
          selectedRequest != null
              ? SlidingPanel(
                  request: selectedRequest,
                )
              : Positioned(bottom: 0, child: _buildRemainigRequests()),
          visible
              ? Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: _buildToast(),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: _currentLocationLatLng == null
          ? Container(
              color: AppColors.accentDark,
            )
          : _buildMapWidget(),
    );
  }

  Widget _buildHeaderChild() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        BackButton(
          color: AppColors.white,
          onPressed: () {
            ExtendedNavigator.of(context)
                .pushAndRemoveUntil(Routes.homeScreen, (route) => false);
          },
        ),
        Text(
          AppStrings.requestsMap,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.white),
        )
      ],
    );
  }

  Widget _buildRefreshButton() {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      onPressed: () {
        locationBloc.dispatch(LocationsRequested());
        setState(() {
          selectedRequest = null;
          requestsLoading = true;
        });
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10.0),
            child: Icon(
              Icons.refresh,
              color: AppColors.black,
            ),
          ),
          Text(
            AppStrings.refresh,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget _buildRemainigRequests() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 12),
      color: AppColors.white,
      child: Center(
        child: requestsLoading
            ? SpinKitThreeBounce(
                color: AppColors.primary,
                size: 20,
              )
            : Text(
                AppStrings.youHave +
                    " " +
                    remainigRequests.length.toString() +
                    " " +
                    AppStrings.remainigRequests,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
      ),
    );
  }

  GoogleMap _buildMapWidget() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      markers: _markers,
      polylines: _polylines,
      compassEnabled: false,
      myLocationButtonEnabled: false,
      zoomGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        target: _currentLocationLatLng,
        zoom: _zoom,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    if (_mapController != null) return;
    _mapController = controller;
  }

  Widget _buildToast() {
    return Container(
      width: double.infinity,
      height: 70,
      child: Card(
        color: AppColors.greenSuccessLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  color: AppColors.greenSuccess,
                ),
                _buildCircularSign(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.problemSent,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      AppStrings.weWillContactSoon,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 10.0, top: 13),
              child: InkWell(
                //padding: EdgeInsets.zero,
                onTap: () {
                  setState(() {
                    visible = false;
                  });
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.greenSuccess,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularSign() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        width: 23,
        height: 23,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.greenSuccess,
        ),
        child: Icon(Icons.check, color: AppColors.white, size: 12));
  }
}
