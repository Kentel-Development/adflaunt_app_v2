// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_profile_model.g.dart';

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class UserProfileModel {
  @JsonKey(name: "averageRating")
  double? averageRating;
  @JsonKey(name: "listings")
  List<Listing>? listings;
  @JsonKey(name: "numberOfReviews")
  double? numberOfReviews;
  @JsonKey(name: "user")
  User? user;
  @JsonKey(name: "yearsOfHosting")
  String? yearsOfHosting;

  UserProfileModel({
    this.averageRating,
    this.listings,
    this.numberOfReviews,
    this.user,
    this.yearsOfHosting,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}

@JsonSerializable()
class Listing {
  @JsonKey(name: "BookingImportURL")
  String? bookingImportUrl;
  @JsonKey(name: "Bookings")
  List<DateTime>? bookings;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "averageRating")
  double? averageRating;
  @JsonKey(name: "bookingNote")
  String? bookingNote;
  @JsonKey(name: "bookingOffset")
  double? bookingOffset;
  @JsonKey(name: "bookingWindow")
  double? bookingWindow;
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
  double? minimumBookingDuration;
  @JsonKey(name: "numberOfReviews")
  double? numberOfReviews;
  @JsonKey(name: "population")
  double? population;
  @JsonKey(name: "price")
  double? price;
  @JsonKey(name: "requirements")
  Requirements? requirements;
  @JsonKey(name: "reviews")
  List<Review>? reviews;
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

  Listing({
    this.bookingImportUrl,
    this.bookings,
    this.id,
    this.address,
    this.averageRating,
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
    this.numberOfReviews,
    this.population,
    this.price,
    this.requirements,
    this.reviews,
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

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);

  Map<String, dynamic> toJson() => _$ListingToJson(this);
}

@JsonSerializable()
class Requirements {
  Requirements();

  factory Requirements.fromJson(Map<String, dynamic> json) =>
      _$RequirementsFromJson(json);

  Map<String, dynamic> toJson() => _$RequirementsToJson(this);
}

@JsonSerializable()
class User {
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
  List<Order>? orders;
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
  @JsonKey(name: "lat")
  double? lat;
  @JsonKey(name: "long")
  double? long;
  @JsonKey(name: "balance")
  double? balance;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "reviews")
  List<Review>? reviews;

  User({
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
    this.phoneNumber,
    this.photoOfId,
    this.profileImage,
    this.stripeCustomerId,
    this.thirdParty,
    this.lat,
    this.long,
    this.balance,
    this.password,
    this.reviews,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Review {
  @JsonKey(name: "at")
  double? at;
  @JsonKey(name: "customer")
  User? customer;
  @JsonKey(name: "host")
  String? host;
  @JsonKey(name: "listing")
  String? listing;
  @JsonKey(name: "revenue")
  double? revenue;
  @JsonKey(name: "review")
  String? review;
  @JsonKey(name: "star")
  double? star;

  Review({
    this.at,
    this.customer,
    this.host,
    this.listing,
    this.revenue,
    this.review,
    this.star,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
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

@JsonSerializable()
class Order {
  @JsonKey(name: "bookingID")
  String? bookingId;
  @JsonKey(name: "customer")
  String? customer;
  @JsonKey(name: "daysWantToBook")
  List<DateTime>? daysWantToBook;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "paymentID")
  String? paymentId;
  @JsonKey(name: "price")
  double? price;
  @JsonKey(name: "pricePerDay")
  double? pricePerDay;
  @JsonKey(name: "printingFile")
  String? printingFile;
  @JsonKey(name: "timeStamp")
  double? timeStamp;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "proofs")
  List<String>? proofs;

  Order({
    this.bookingId,
    this.customer,
    this.daysWantToBook,
    this.description,
    this.paymentId,
    this.price,
    this.pricePerDay,
    this.printingFile,
    this.timeStamp,
    this.title,
    this.proofs,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
