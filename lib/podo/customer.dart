import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tagaddod/podo/address.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer with Parser<Customer> {
  String id;
  String name;
  String phone;
  Address address;

  Customer.empty();
  Customer(
    this.id,
    this.name,
    this.phone,
    this.address,
  );

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  Customer parse(data) {
    return Customer.fromJson(data);
  }
}
