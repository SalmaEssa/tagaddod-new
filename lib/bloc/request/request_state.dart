import 'package:tagaddod/podo/complainType.dart';
import 'package:tagaddod/podo/gift.dart';
import 'package:tagaddod/podo/request.dart';

abstract class RequestState {}

class AvailableGiftsAre extends RequestState {
  List<Gift> gifts;
  AvailableGiftsAre(this.gifts);
}

class SelectedGiftIs extends RequestState {
  Gift selectedGift;
  SelectedGiftIs(this.selectedGift);
}

class CollectionIsConfirmed extends RequestState {}

class RatingIsAdded extends RequestState {}

class PastRequestsAre extends RequestState {
  List<Request> pastRequests;
  PastRequestsAre(this.pastRequests);
}

class AllComplainsAre extends RequestState {
  List<ComplainType> complains;
  AllComplainsAre(this.complains);
}

class ComplainAddedIS extends RequestState{}

class ComplainStatusIs extends RequestState{
  bool status;
  ComplainStatusIs(this.status);
}