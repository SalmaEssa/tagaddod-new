import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tagaddod/podo/customer.dart';
import 'package:tagaddod/podo/request.dart';

part'customerRating.g.dart';

@JsonSerializable()
class CustomerRating with Parser<CustomerRating>{
  int rate;
  Customer customer;
  Request request;
  String status;

  CustomerRating.empty();
  CustomerRating(
    this.rate,
    this.customer,
    this.request,
    this.status,
  );

  factory CustomerRating.fromJson(Map<String, dynamic> json) => _$CustomerRatingFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRatingToJson(this);

  @override
  CustomerRating parse(data) {
    return CustomerRating.fromJson(data);
  }
}