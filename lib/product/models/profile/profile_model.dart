// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'profile_model.g.dart';

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

@JsonSerializable()
class ProfileModel {
  @JsonKey(name: "IPDATA")
  Ipdata ipdata;
  @JsonKey(name: "SCC", includeIfNull: false)
  bool? scc;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "dateOfBirth", includeIfNull: false)
  String? dateOfBirth;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "fullName")
  String fullName;
  @JsonKey(name: "idVerified")
  bool idVerified;
  @JsonKey(name: "ipraw")
  String ipraw;
  @JsonKey(name: "lastTimeLoggedIn", includeIfNull: false)
  double? lastTimeLoggedIn;
  @JsonKey(name: "password", includeIfNull: false)
  String? password;
  @JsonKey(name: "phoneNumber", includeIfNull: false)
  String? phoneNumber;
  @JsonKey(name: "profileImage", includeIfNull: false)
  dynamic profileImage;
  @JsonKey(name: "thirdParty")
  String thirdParty;

  ProfileModel({
    required this.ipdata,
    required this.scc,
    required this.id,
    required this.dateOfBirth,
    required this.email,
    required this.fullName,
    required this.idVerified,
    required this.ipraw,
    required this.lastTimeLoggedIn,
    required this.password,
    required this.phoneNumber,
    this.profileImage,
    required this.thirdParty,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
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
