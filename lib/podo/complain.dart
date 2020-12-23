import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/podo/complainType.dart';
import 'package:tagaddod/podo/customer.dart';
import 'package:tagaddod/podo/request.dart';

part 'complain.g.dart';

@JsonSerializable()
class Complain with Parser<Complain> {
  String id;
  Collector collector;
  Customer customer;
  Request request;
  ComplainType complainType;
  String complainer;
  String description;

  Complain.empty();
  Complain(
    this.id,
    this.collector,
    this.customer,
    this.request,
    this.complainType,
    this.complainer,
    this.description,
  );

  factory Complain.fromJson(Map<String, dynamic> json) =>
      _$ComplainFromJson(json);

  Map<String, dynamic> toJson() => _$ComplainToJson(this);

  @override
  Complain parse(data) {
    return Complain.fromJson(data);
  }
}
