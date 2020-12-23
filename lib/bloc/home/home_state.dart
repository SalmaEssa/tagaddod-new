import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/podo/regionRequest.dart';

abstract class HomeState{}

class PastSuccessRequestsAre extends HomeState{
  int yestertdayReqs;
  int monthReqs;
  PastSuccessRequestsAre(this.yestertdayReqs,this.monthReqs);
}

class PastFailedRequestsAre extends HomeState{
  int yestertdayReqs;
  int monthReqs;
  PastFailedRequestsAre(this.yestertdayReqs,this.monthReqs);
}

class TodayRequestsAre extends HomeState{
  int collected;
  int pending;
  int failed;
  TodayRequestsAre(this.collected,this.pending,this.failed);
}

class RegionRequestsAre extends HomeState{
  List<RegionRequest> regionRequests;
  RegionRequestsAre(this.regionRequests);
}

class CollectorIs extends HomeState{
  Collector collector;
  CollectorIs(this.collector);
}