import 'package:fly_networking/GraphQB/graph_qb.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/podo/complainType.dart';
import 'package:tagaddod/podo/gift.dart';
import 'package:tagaddod/podo/request.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/support/Maps/MapHelper.dart';

class RequestService {
  final Fly _fly = GetIt.instance<Fly>();
  List requestCols = [
    "id",
    "collection_date",
    "notes",
    "created_at",
    "collected_quantity",
    Node(name: "gift", cols: ["id", "name"]),
    "status",
    "rated_by_collector",
    "rated_by_customer",
    Node(name: "customerRating", cols: ["rate", "status"]),
    Node(name: "customer", cols: ["id", "name", "phone"]),
    Node(name: "address", cols: ["id", "longitude", "latitude", "description"]),
    Node(name: "complain", cols: ["id", "description"]),
  ];
  Location location = new Location();
  LocationData _locationData;
  Marker myLocation;
  MapHelper _mapHelper = MapHelper();

  Future<List<Gift>> getAvailableGifts(int litres) async {
    Node gifts = Node(
        name: "availableGifts",
        args: {"collected_quantity": litres},
        cols: ["id", "name", "level"]);
    dynamic results =
        await _fly.query([gifts], parsers: {'availableGifts': Gift.empty()});
    return results['availableGifts'];
  }

  Future<dynamic> confirmCollection(
      String collectorID, String reqID, String giftID, int quantity) async {
    Node confirmCollection = Node(name: "updateCollector", args: {
      "id": collectorID,
      "input": {
        "requests": {
          "update": {
            "id": reqID,
            "status": "_COLLECTED",
            "collected_quantity": quantity,
            "gift": {"connect": giftID}
          }
        }
      }
    }, cols: [
      "id"
    ]);
    await _fly.mutation([confirmCollection],
        parsers: {'updateCollector': Collector.empty()});
  }

  Future<dynamic> addRating(
      String collectorID, String reqID, String status, int rate) async {
    Node confirmCollection = Node(name: "updateCollector", args: {
      "id": collectorID,
      "input": {
        "requests": {
          "update": {
            "id": reqID,
            "customerRating": {
              "create": {"rate": rate, "status": "_" + status}
            }
          }
        }
      }
    }, cols: [
      "id"
    ]);
    await _fly.mutation([confirmCollection],
        parsers: {'updateCollector': Collector.empty()});
  }

  Future<dynamic> getPastRequests() async {
    Node pastRequests = Node(name: "myCollector", cols: [
      Node(
          name: "requests",
          args: {
            "where": {
              "OR": [
                {"column": "_STATUS", "operator": "_EQ", "value": "_FAILED"},
                {"column": "_STATUS", "operator": "_EQ", "value": "_COLLECTED"},
                {"column": "_STATUS", "operator": "_EQ", "value": "_REPORTED"}
              ]
            }
          },
          cols: requestCols)
    ]);
    dynamic results = await _fly
        .query([pastRequests], parsers: {'myCollector': Collector.empty()});
    return results['myCollector'];
  }

  Future<dynamic> getComplains() async {
    Node complains = Node(name: "complainTypes", cols: ["id", "name"]);
    dynamic results = await _fly
        .query([complains], parsers: {'complainTypes': ComplainType.empty()});
    return results['complainTypes'];
  }

  Future<void> addComplain(String collectorID, String reqID, String complainID,
      String description) async {
    String des = description!=""?description.replaceAll('"', '\\"'):null;
    Node addComplain = Node(name: "updateCollector", args: {
      "id": collectorID,
      "input": {
        "requests": {
          "update": {
            "id": reqID,
            "complain": {
              "create": {
                "complainType": {"connect": complainID},
                "description": des
              }
            }
          }
        }
      }
    }, cols: [
      "id"
    ]);
    await _fly.mutation([addComplain],
        parsers: {'updateCollector': Collector.empty()});
  }

  Future<Marker> getMyLocation() async {
    _locationData = await location.getLocation();
    myLocation = await _mapHelper.getMarker(
      LatLng(
        _locationData.latitude,
        _locationData.longitude,
      ),
      AssetStrings.myLocation,
      "My location",
      () {},
    );
    return myLocation;
  }

  LatLng getCenter(List<Request> requests) {
    int totalRequests = requests.length;
    double totalLat = 0;
    double totalLong = 0;
    for (var request in requests) {
      totalLat += double.parse(request.address.latitude);
      totalLong += double.parse(request.address.longitude);
    }
    double centerLat = totalLat / totalRequests;
    double cneterLong = totalLong / totalRequests;
    LatLng _currentLocationLatLng = LatLng(centerLat, cneterLong);
    return _currentLocationLatLng;
  }
}
