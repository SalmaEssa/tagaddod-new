import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';

class MapHelper {
  Future<bool> locationGranted() async {
    Location location = Location();
    PermissionStatus ps = PermissionStatus.granted;
    if ((await location.hasPermission()) != PermissionStatus.granted) {
      ps = await location.requestPermission();
    }
    bool sG = false;
    if (ps == PermissionStatus.granted) {
      sG = await location.requestService();
    }
    return sG;
  }

  Future<String> getAddressFromLocation(LatLng myLoc) async {
    String address = "";
    final coordinates = new Coordinates(myLoc.latitude, myLoc.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    if (addresses == null || addresses.isEmpty) return address;

    var first = addresses.first;
    address += first.addressLine == null ? '' : '${first.addressLine}, ';
    return address;
  }

  Future<Marker> getMarker(
      LatLng myLoc, String markerIcon, String markerId,void Function() onTap) async {
    Marker newMarker = Marker(
      onTap: onTap,
      markerId: MarkerId(markerId),
      position: myLoc,
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), markerIcon),
    );
    return newMarker;
  }

  Future<Address> getLocationByQuery(String query) async {
    List<Address> addresses;
    if (Platform.isIOS) {
      addresses = await Geocoder.google(CodeStrings.googleMapsServerAPI)
          .findAddressesFromQuery(query);
    } else {
      addresses = await Geocoder.local.findAddressesFromQuery(query);
    }
    if (addresses.first == null) {
      return null;
    }
    return addresses.first;
  }

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&mode=walking&key=${CodeStrings.googleMapsServerAPI}";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    print("VALUES :: " + response.body.toString());
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Set<Polyline> createRoute(String id, String encondedPoly) {
    Set<Polyline> polyLines = Set();
    polyLines.add(Polyline(
        polylineId: PolylineId(id),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: AppColors.white));
    return polyLines;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    print(lList.toString());
    return lList;
  }
}
