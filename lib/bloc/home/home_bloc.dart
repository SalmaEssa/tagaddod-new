import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tagaddod/bloc/bloc.dart';
import 'package:tagaddod/bloc/home/bloc.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/services/home.dart';

class HomeBloc extends BLoC<HomeEvent> {
  final PublishSubject homeSubject = PublishSubject<HomeState>();
  HomeService _homeService = GetIt.instance<HomeService>();

  @override
  void dispatch(HomeEvent event) async {
    if (event is HomePageLaunched) {
      // i commenteed hereeee
      await getTodayRequests();
      await getPastSuccessRequests();
      await getPastFailedRequests();
      await getRegionsRequests();
      await getCollector();
    }

    if (event is CollectorRequested) {
      await getCollector();
    }
  }

  Future<void> getCollector() async {
    Collector collector = await _homeService.getCollector();
    homeSubject.sink.add(CollectorIs(collector));
  }

  Future<void> getTodayRequests() async {
    int collected = await _homeService.getTodayCollectedRequests();
    int pending = await _homeService.getTodayPendingRequests();
    int failed = await _homeService.getTodayFailedRequests();
    homeSubject.sink.add(TodayRequestsAre(collected, pending, failed));
  }

  Future<void> getPastSuccessRequests() async {
    Collector collector = await _homeService.getPastSuccessRequests();
    homeSubject.sink.add(PastSuccessRequestsAre(
        collector.yesterday_requests, collector.month_requests));
    ////
  }

  Future<void> getPastFailedRequests() async {
    Collector collector = await _homeService.getPastFailedRequests();
    homeSubject.sink.add(PastFailedRequestsAre(
        collector.yesterday_requests, collector.month_requests));
  }

  Future<void> getRegionsRequests() async {
    Collector collector = await _homeService.getRegionsRequests();
    homeSubject.sink.add(RegionRequestsAre(collector.regions_requests));
  }

  void dispose() {
    homeSubject.close();
  }
}
