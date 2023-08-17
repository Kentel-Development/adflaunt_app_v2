import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'ipdata.dart';
import 'orders.dart';
part 'customer.g.dart';

@JsonSerializable()
class Customer with EquatableMixin {
  Ipdata? ipdata;
  String? id;
  String? dateOfBirth;
  String? email;
  String? fullName;
  bool? idVerified;
  String? ipraw;
  double? lastTimeLoggedIn;
  double? lat;
  double? long;
  List<Orders>? orders;
  String? phoneNumber;
  String? profileImage;
  String? stripeCustomerID;
  String? thirdParty;

  Customer({
    this.ipdata,
    this.id,
    this.dateOfBirth,
    this.email,
    this.fullName,
    this.idVerified,
    this.ipraw,
    this.lastTimeLoggedIn,
    this.lat,
    this.long,
    this.orders,
    this.phoneNumber,
    this.profileImage,
    this.stripeCustomerID,
    this.thirdParty,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  List<Object?> get props => [
        ipdata,
        id,
        dateOfBirth,
        email,
        fullName,
        idVerified,
        ipraw,
        lastTimeLoggedIn,
        lat,
        long,
        orders,
        phoneNumber,
        profileImage,
        stripeCustomerID,
        thirdParty
      ];

  Customer copyWith({
    Ipdata? ipdata,
    String? id,
    String? dateOfBirth,
    String? email,
    String? fullName,
    bool? idVerified,
    String? ipraw,
    double? lastTimeLoggedIn,
    double? lat,
    double? long,
    List<Orders>? orders,
    String? phoneNumber,
    String? profileImage,
    String? stripeCustomerID,
    String? thirdParty,
  }) {
    return Customer(
      ipdata: ipdata ?? this.ipdata,
      id: id ?? this.id,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      idVerified: idVerified ?? this.idVerified,
      ipraw: ipraw ?? this.ipraw,
      lastTimeLoggedIn: lastTimeLoggedIn ?? this.lastTimeLoggedIn,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      orders: orders ?? this.orders,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      stripeCustomerID: stripeCustomerID ?? this.stripeCustomerID,
      thirdParty: thirdParty ?? this.thirdParty,
    );
  }
}
