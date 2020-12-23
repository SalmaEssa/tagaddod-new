import 'package:tagaddod/podo/gift.dart';
import 'package:tagaddod/podo/request.dart';

abstract class RequestEvent {}

class GetAvailableGifts extends RequestEvent {
  int litres;
  GetAvailableGifts(this.litres);
}

class GiftSelected extends RequestEvent {
  Gift gift;
  GiftSelected(this.gift);
}

class GetSelectedGift extends RequestEvent {}

class CollectionConfirmed extends RequestEvent {
  String requestID;
  int quantity;
  String giftID;
  CollectionConfirmed(this.requestID, this.quantity, this.giftID);
}

class RatingAdded extends RequestEvent {
  String reqID;
  int rate;
  String status;
  RatingAdded(this.reqID, this.rate, this.status);
}

class GetAllPastRequests extends RequestEvent {}

class GetAllComplains extends RequestEvent {}

class SetSelectedRequest extends RequestEvent {
  Request request;
  SetSelectedRequest(this.request);
}

class ComplainAdded extends RequestEvent{
  String complainID;
  String description;
  ComplainAdded(this.complainID,this.description);
}

class GetComplainStatus extends RequestEvent{}
class UpdateComplainStatus extends RequestEvent{
  bool status;
  UpdateComplainStatus(this.status);
}
