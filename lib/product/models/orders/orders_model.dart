// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'orders_model.g.dart';

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

@JsonSerializable()
class OrdersModel {
  @JsonKey(name: "SCC")
  bool? scc;
  @JsonKey(name: "asCustomer")
  List<As>? asCustomer;
  @JsonKey(name: "asHost")
  List<As>? asHost;
  @JsonKey(name: "userData")
  UserData? userData;
  @JsonKey(name: "user_type")
  String? userType;

  OrdersModel({
    this.scc,
    this.asCustomer,
    this.asHost,
    this.userData,
    this.userType,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersModelToJson(this);
}

@JsonSerializable()
class As {
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "listingData")
  ListingData? listingData;
  @JsonKey(name: "status")
  String? status;

  As({
    this.data,
    this.listingData,
    this.status,
  });

  factory As.fromJson(Map<String, dynamic> json) => _$AsFromJson(json);

  Map<String, dynamic> toJson() => _$AsToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "bookingID")
  String? bookingId;
  @JsonKey(name: "click_action")
  String? clickAction;
  @JsonKey(name: "customer")
  String? customer;
  @JsonKey(name: "daysWantToBook")
  List<DateTime>? daysWantToBook;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "page")
  String? page;
  @JsonKey(name: "paymentID")
  String? paymentId;
  @JsonKey(name: "price")
  double? price;
  @JsonKey(name: "pricePerDay")
  double? pricePerDay;
  @JsonKey(name: "printingFile")
  dynamic printingFile;
  @JsonKey(name: "timeStamp")
  double? timeStamp;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "proofs")
  List<String>? proofs;

  Data({
    this.bookingId,
    this.clickAction,
    this.customer,
    this.daysWantToBook,
    this.description,
    this.page,
    this.paymentId,
    this.price,
    this.pricePerDay,
    this.printingFile,
    this.timeStamp,
    this.title,
    this.proofs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ListingData {
  @JsonKey(name: "BookingImportURL")
  String? bookingImportUrl;
  @JsonKey(name: "Bookings")
  List<DateTime>? bookings;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "bookingNote")
  String? bookingNote;
  @JsonKey(name: "bookingOffset")
  int? bookingOffset;
  @JsonKey(name: "bookingWindow")
  int? bookingWindow;
  @JsonKey(name: "cancel")
  bool? cancel;
  @JsonKey(name: "check_in")
  String? checkIn;
  @JsonKey(name: "check_out")
  String? checkOut;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "extras")
  List<dynamic>? extras;
  @JsonKey(name: "height")
  double? height;
  @JsonKey(name: "images")
  List<String>? images;
  @JsonKey(name: "inchFootage")
  double? inchFootage;
  @JsonKey(name: "lat")
  double? lat;
  @JsonKey(name: "location")
  String? location;
  @JsonKey(name: "long")
  double? long;
  @JsonKey(name: "minimumBookingDuration")
  int? minimumBookingDuration;
  @JsonKey(name: "population")
  int? population;
  @JsonKey(name: "price")
  double? price;
  @JsonKey(name: "requirements")
  Requirements? requirements;
  @JsonKey(name: "revision_limit")
  String? revisionLimit;
  @JsonKey(name: "sqfeet")
  double? sqfeet;
  @JsonKey(name: "sqfootage")
  double? sqfootage;
  @JsonKey(name: "state")
  String? state;
  @JsonKey(name: "tags")
  List<String>? tags;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "typeOfAdd")
  String? typeOfAdd;
  @JsonKey(name: "user")
  String? user;
  @JsonKey(name: "width")
  double? width;
  @JsonKey(name: "zipCode")
  String? zipCode;

  ListingData({
    this.bookingImportUrl,
    this.bookings,
    this.id,
    this.address,
    this.bookingNote,
    this.bookingOffset,
    this.bookingWindow,
    this.cancel,
    this.checkIn,
    this.checkOut,
    this.city,
    this.country,
    this.description,
    this.extras,
    this.height,
    this.images,
    this.inchFootage,
    this.lat,
    this.location,
    this.long,
    this.minimumBookingDuration,
    this.population,
    this.price,
    this.requirements,
    this.revisionLimit,
    this.sqfeet,
    this.sqfootage,
    this.state,
    this.tags,
    this.title,
    this.type,
    this.typeOfAdd,
    this.user,
    this.width,
    this.zipCode,
  });

  factory ListingData.fromJson(Map<String, dynamic> json) =>
      _$ListingDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListingDataToJson(this);
}

@JsonSerializable()
class Requirements {
  Requirements();

  factory Requirements.fromJson(Map<String, dynamic> json) =>
      _$RequirementsFromJson(json);

  Map<String, dynamic> toJson() => _$RequirementsToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: "IPDATA")
  Ipdata? ipdata;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "backPhotoID")
  String? backPhotoId;
  @JsonKey(name: "dateOfBirth")
  String? dateOfBirth;
  @JsonKey(name: "deliveryAddress")
  String? deliveryAddress;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "fullName")
  String? fullName;
  @JsonKey(name: "idVerified")
  bool? idVerified;
  @JsonKey(name: "inbox")
  List<String>? inbox;
  @JsonKey(name: "ipraw")
  String? ipraw;
  @JsonKey(name: "lastTimeLoggedIn")
  double? lastTimeLoggedIn;
  @JsonKey(name: "orders")
  List<Data>? orders;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "photoOfId")
  String? photoOfId;
  @JsonKey(name: "profileImage")
  String? profileImage;
  @JsonKey(name: "stripeCustomerID")
  String? stripeCustomerId;
  @JsonKey(name: "thirdParty")
  String? thirdParty;

  UserData({
    this.ipdata,
    this.id,
    this.backPhotoId,
    this.dateOfBirth,
    this.deliveryAddress,
    this.email,
    this.fullName,
    this.idVerified,
    this.inbox,
    this.ipraw,
    this.lastTimeLoggedIn,
    this.orders,
    this.password,
    this.phoneNumber,
    this.photoOfId,
    this.profileImage,
    this.stripeCustomerId,
    this.thirdParty,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class Ipdata {
  @JsonKey(name: "as")
  String? ipdataAs;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "countryCode")
  String? countryCode;
  @JsonKey(name: "isp")
  String? isp;
  @JsonKey(name: "lat")
  double? lat;
  @JsonKey(name: "lon")
  double? lon;
  @JsonKey(name: "org")
  String? org;
  @JsonKey(name: "query")
  String? query;
  @JsonKey(name: "region")
  String? region;
  @JsonKey(name: "regionName")
  String? regionName;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "timezone")
  String? timezone;
  @JsonKey(name: "zip")
  String? zip;

  Ipdata({
    this.ipdataAs,
    this.city,
    this.country,
    this.countryCode,
    this.isp,
    this.lat,
    this.lon,
    this.org,
    this.query,
    this.region,
    this.regionName,
    this.status,
    this.timezone,
    this.zip,
  });

  factory Ipdata.fromJson(Map<String, dynamic> json) => _$IpdataFromJson(json);

  Map<String, dynamic> toJson() => _$IpdataToJson(this);
}
