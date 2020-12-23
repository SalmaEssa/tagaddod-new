import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tagaddod/podo/address.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/podo/complain.dart';
import 'package:tagaddod/podo/customer.dart';
import 'package:tagaddod/podo/customerRating.dart';
import 'package:tagaddod/podo/gift.dart';

part 'request.g.dart';

@JsonSerializable()
class Request with Parser<Request> {
  String id;
  Collector collector;
  Gift gift;
  String status;
  DateTime collection_date;
  String notes;
  DateTime created_at;
  int collected_quantity;
  Customer customer;
  Address address;
  bool rated_by_collector;
  bool rated_by_customer;
  CustomerRating customerRating;
  Complain complain;

  Request.empty();

  Request(
    this.id,
    this.collector,
    this.gift,
    this.status,
    this.collection_date,
    this.notes,
    this.created_at,
    this.collected_quantity,
    this.customer,
    this.address,
    this.complain,
  );

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);

  @override
  Request parse(data) {
    return Request.fromJson(data);
  }
}
