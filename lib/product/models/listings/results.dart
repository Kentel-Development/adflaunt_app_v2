// To parse this JSON data, do
//
//     final results = resultsFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'results.g.dart';

Results resultsFromJson(String str) =>
    Results.fromJson(json.decode(str) as Map<String, dynamic>);

String resultsToJson(Results data) => json.encode(data.toJson());

@JsonSerializable()
class Results {
  @JsonKey(name: "SCC")
  bool scc;
  @JsonKey(name: "output")
  List<Output> output;
  @JsonKey(name: "sid", includeIfNull: true)
  String? sid;

  Results({
    required this.scc,
    required this.output,
    this.sid,
  });

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}

@JsonSerializable()
class Output {
  @JsonKey(name: "zipCode")
  String zipCode;
  @JsonKey(name: "BookingImportURL")
  String bookingImportUrl;
  @JsonKey(name: "Bookings")
  List<DateTime>? bookings;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "averageRating")
  double? averageRating;
  @JsonKey(name: "bookingNote")
  String bookingNote;
  @JsonKey(name: "bookingOffset")
  double? bookingOffset;
  @JsonKey(name: "bookingWindow")
  double? bookingWindow;
  @JsonKey(name: "check_in")
  String checkIn;
  @JsonKey(name: "check_out")
  String checkOut;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "country")
  String country;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "extras")
  List<dynamic> extras;
  @JsonKey(name: "height")
  double height;
  @JsonKey(name: "images")
  List<String> images;
  @JsonKey(name: "inchFootage")
  double inchFootage;
  @JsonKey(name: "lat")
  double lat;
  @JsonKey(name: "location")
  String location;
  @JsonKey(name: "long")
  double long;
  @JsonKey(name: "minimumBookingDuration")
  double? minimumBookingDuration;
  @JsonKey(name: "numberOfReviews")
  dynamic numberOfReviews;
  @JsonKey(name: "population")
  double? population;
  @JsonKey(name: "price")
  double price;
  @JsonKey(name: "requirements")
  Requirements requirements;
  @JsonKey(name: "revision_limit")
  String revisionLimit;
  @JsonKey(name: "sqfeet")
  double sqfeet;
  @JsonKey(name: "sqfootage")
  double sqfootage;
  @JsonKey(name: "state")
  String state;
  @JsonKey(name: "tags")
  List<String> tags;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "typeOfAdd")
  String typeOfAdd;
  @JsonKey(name: "user")
  String user;
  @JsonKey(name: "width")
  double width;
  @JsonKey(name: "reviews")
  List<Review>? reviews;
  @JsonKey(name: "cancel")
  bool? cancel;

  Output({
    required this.zipCode,
    required this.bookingImportUrl,
    this.bookings,
    required this.id,
    required this.averageRating,
    required this.bookingNote,
    required this.bookingOffset,
    required this.bookingWindow,
    required this.checkIn,
    required this.checkOut,
    required this.city,
    required this.country,
    required this.description,
    required this.cancel,
    required this.extras,
    required this.height,
    required this.images,
    required this.inchFootage,
    required this.lat,
    required this.location,
    required this.long,
    required this.minimumBookingDuration,
    required this.numberOfReviews,
    required this.population,
    required this.price,
    required this.requirements,
    required this.revisionLimit,
    required this.sqfeet,
    required this.sqfootage,
    required this.state,
    required this.tags,
    required this.title,
    required this.type,
    required this.typeOfAdd,
    required this.user,
    required this.width,
    this.reviews,
  });

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  Map<String, dynamic> toJson() => _$OutputToJson(this);
}

@JsonSerializable()
class Requirements {
  Requirements();

  factory Requirements.fromJson(Map<String, dynamic> json) =>
      _$RequirementsFromJson(json);

  Map<String, dynamic> toJson() => _$RequirementsToJson(this);
}

@JsonSerializable()
class Review {
  @JsonKey(name: "at")
  double at;
  @JsonKey(name: "customer")
  Customer customer;
  @JsonKey(name: "host")
  String host;
  @JsonKey(name: "listing")
  String listing;
  @JsonKey(name: "revenue")
  double revenue;
  @JsonKey(name: "review")
  String review;
  @JsonKey(name: "star")
  double star;

  Review({
    required this.at,
    required this.customer,
    required this.host,
    required this.listing,
    required this.revenue,
    required this.review,
    required this.star,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class Customer {
  @JsonKey(name: "IPDATA")
  Ipdata ipdata;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "dateOfBirth")
  String? dateOfBirth;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "fullName")
  String fullName;
  @JsonKey(name: "idVerified")
  bool? idVerified;
  @JsonKey(name: "ipraw")
  String? ipraw;
  @JsonKey(name: "lastTimeLoggedIn")
  double lastTimeLoggedIn;
  @JsonKey(name: "lat")
  double? lat;
  @JsonKey(name: "long")
  double? long;
  @JsonKey(name: "orders")
  List<Order>? orders;
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "profileImage")
  dynamic profileImage;
  @JsonKey(name: "stripeCustomerID")
  String? stripeCustomerId;
  @JsonKey(name: "thirdParty")
  String thirdParty;

  Customer({
    required this.ipdata,
    required this.id,
    required this.dateOfBirth,
    required this.email,
    required this.fullName,
    required this.idVerified,
    required this.ipraw,
    required this.lastTimeLoggedIn,
    required this.lat,
    required this.long,
    required this.orders,
    required this.phoneNumber,
    this.profileImage,
    required this.stripeCustomerId,
    required this.thirdParty,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

@JsonSerializable()
class Ipdata {
  @JsonKey(name: "as")
  String ipdataAs;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "country")
  String country;
  @JsonKey(name: "countryCode")
  String countryCode;
  @JsonKey(name: "isp")
  String isp;
  @JsonKey(name: "lat")
  double lat;
  @JsonKey(name: "lon")
  double lon;
  @JsonKey(name: "org")
  String org;
  @JsonKey(name: "query")
  String query;
  @JsonKey(name: "region")
  String region;
  @JsonKey(name: "regionName")
  String regionName;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "timezone")
  String timezone;
  @JsonKey(name: "zip")
  String zip;

  Ipdata({
    required this.ipdataAs,
    required this.city,
    required this.country,
    required this.countryCode,
    required this.isp,
    required this.lat,
    required this.lon,
    required this.org,
    required this.query,
    required this.region,
    required this.regionName,
    required this.status,
    required this.timezone,
    required this.zip,
  });

  factory Ipdata.fromJson(Map<String, dynamic> json) => _$IpdataFromJson(json);

  Map<String, dynamic> toJson() => _$IpdataToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: "bookingID")
  String bookingId;
  @JsonKey(name: "customer")
  String customer;
  @JsonKey(name: "daysWantToBook")
  List<DateTime> daysWantToBook;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "paymentID")
  String paymentId;
  @JsonKey(name: "price")
  double price;
  @JsonKey(name: "pricePerDay")
  double pricePerDay;
  @JsonKey(name: "printingFile")
  dynamic printingFile;
  @JsonKey(name: "timeStamp")
  double timeStamp;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "proofs")
  List<String>? proofs;

  Order({
    required this.bookingId,
    required this.customer,
    required this.daysWantToBook,
    required this.description,
    required this.paymentId,
    required this.price,
    required this.pricePerDay,
    required this.printingFile,
    required this.timeStamp,
    required this.title,
    this.proofs,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
