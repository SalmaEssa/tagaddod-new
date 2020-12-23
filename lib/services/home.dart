import 'package:fly_networking/GraphQB/graph_qb.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/podo/request.dart';

class HomeService {
  final Fly _fly = GetIt.instance<Fly<dynamic>>();
  Collector collector;

  List requestCols = [
    "id",
    "collection_date",
    "notes",
    "created_at",
    "collected_quantity",
    Node(name: "gift", cols: ["id", "name"]),
    "status",
    Node(name: "customer", cols: ["id", "name", "phone"]),
    Node(name: "address", cols: ["id", "longitude", "latitude", "description"]),
  ];

  Future<Collector> getCollector() async {
    if (collector != null) {
      return collector;
    }
    Node pastRequests = Node(name: "myCollector", cols: [
      "id", // this columns will return from the query
      "name",
      "phone",
    ]);
    dynamic results = await _fly
        .query([pastRequests], parsers: {'myCollector': Collector.empty()});
    collector = results['myCollector'];
    return collector;
  }

  Future<int> getTodayCollectedRequests() async {
    Node pastRequests = Node(name: "myCollector", cols: [
      Node(name: "today_requests", args: {"request_status": "_COLLECTED"}),
    ]);
    dynamic results = await _fly
        .query([pastRequests], parsers: {'myCollector': Collector.empty()});
    Collector collector = results['myCollector'];
    return collector.today_requests;
  }

  Future<int> getTodayPendingRequests() async {
    Node pastRequests = Node(name: "myCollector", cols: [
      Node(name: "today_requests", args: {"request_status": "_DISPATCHED"}),
    ]);
    dynamic results = await _fly
        .query([pastRequests], parsers: {'myCollector': Collector.empty()});
    Collector collector = results['myCollector'];
    return collector.today_requests;
  }

  Future<int> getTodayFailedRequests() async {
    Node pastRequests = Node(name: "myCollector", cols: [
      Node(name: "today_requests", args: {"request_status": "_FAILED"}),
    ]);
    dynamic results = await _fly
        .query([pastRequests], parsers: {'myCollector': Collector.empty()});
    Collector collector = results['myCollector'];
    return collector.today_requests;
  }

  Future<Collector> getPastSuccessRequests() async {
    Node pastRequests = Node(name: "myCollector", cols: [
      Node(name: "yesterday_requests", args: {"request_status": "_COLLECTED"}),
      Node(name: "month_requests", args: {"request_status": "_COLLECTED"})
    ]);
    dynamic results = await _fly
        .query([pastRequests], parsers: {'myCollector': Collector.empty()});
    print("here is your query result ");
    print(results);
    return results['myCollector'];
  }

  Future<Collector> getPastFailedRequests() async {
    Node pastRequests = Node(name: "myCollector", cols: [
      Node(name: "yesterday_requests", args: {"request_status": "_FAILED"}),
      Node(name: "month_requests", args: {"request_status": "_FAILED"})
    ]);
    dynamic results = await _fly
        .query([pastRequests], parsers: {'myCollector': Collector.empty()});
    return results['myCollector'];
  }

  Future<Collector> getRegionsRequests() async {
    Node regionsRequests = Node(name: "myCollector", cols: [
      Node(
          name: "regions_requests",
          cols: ["name", "total", Node(name: "requests", cols: requestCols)]),
    ]);
    dynamic results = await _fly
        .query([regionsRequests], parsers: {'myCollector': Collector.empty()});
    return results['myCollector'];
  }
}
