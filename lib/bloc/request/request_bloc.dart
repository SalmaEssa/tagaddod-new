import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tagaddod/bloc/bloc.dart';
import 'package:tagaddod/bloc/home/home_bloc.dart';
import 'package:tagaddod/bloc/request/bloc.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/podo/complainType.dart';
import 'package:tagaddod/podo/gift.dart';
import 'package:tagaddod/podo/request.dart';
import 'package:tagaddod/services/home.dart';
import 'package:tagaddod/services/request.dart';

class RequestBloc extends BLoC<RequestEvent> {
  final PublishSubject<RequestState> requestStateSubject = PublishSubject();
  RequestService requestService = GetIt.instance<RequestService>();
  HomeService homeService = GetIt.instance<HomeService>();
  Gift selectedGift;
  Request request;
  bool complainadded = false;

  @override
  void dispatch(RequestEvent event) async {
    if (event is GetAvailableGifts) {
      await getAvailableGifts(event);
    }

    if (event is GiftSelected) {
      selectedGift = event.gift;
      requestStateSubject.sink.add(SelectedGiftIs(event.gift));
    }

    if (event is GetSelectedGift) {
      requestStateSubject.sink.add(SelectedGiftIs(selectedGift));
    }

    if (event is CollectionConfirmed) {
      await confirmCollection(event);
    }

    if (event is RatingAdded) {
      await addRating(event);
    }

    if (event is GetAllPastRequests) {
      await getPastRequests();
    }

    if (event is GetAllComplains) {
      await getComplains();
    }

    if (event is SetSelectedRequest) {
      request = event.request;
    }

    if (event is ComplainAdded) {
      await addComplain(event);
    }

    if (event is GetComplainStatus) {
      requestStateSubject.sink.add(ComplainStatusIs(complainadded));
    }

    if(event is UpdateComplainStatus){
      complainadded = false;
    }
  }

  Future<void> getAvailableGifts(event) async {
    List<Gift> gifts = await requestService.getAvailableGifts(event.litres);
    requestStateSubject.sink.add(AvailableGiftsAre(gifts));
  }

  Future<void> confirmCollection(event) async {
    Collector collector = await homeService.getCollector();
    await requestService.confirmCollection(
        collector.id, event.requestID, event.giftID, event.quantity);
    requestStateSubject.sink.add(CollectionIsConfirmed());
  }

  Future<void> addRating(event) async {
    Collector collector = await homeService.getCollector();
    await requestService.addRating(
        collector.id, event.reqID, event.status, event.rate);
    requestStateSubject.sink.add(RatingIsAdded());
  }

  Future<void> getPastRequests() async {
    List<Request> requests;
    Collector collector = await requestService.getPastRequests();
    requests = collector.requests;
    requestStateSubject.sink.add(PastRequestsAre(requests));
  }

  Future<void> getComplains() async {
    List<ComplainType> complains;
    complains = await requestService.getComplains();
    requestStateSubject.sink.add(AllComplainsAre(complains));
  }

  Future<void> addComplain(event) async {
    Collector collector = await homeService.getCollector();
    await requestService.addComplain(
        collector.id, request.id, event.complainID, event.description);
    complainadded = true;
    requestStateSubject.sink.add(ComplainAddedIS());
  }

  dispose() {
    requestStateSubject.close();
  }
}
