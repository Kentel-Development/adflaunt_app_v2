// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'package:adflaunt/product/models/orders/orders_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'chat.g.dart';

String chatToJson(Chat data) => json.encode(data.toJson());

@JsonSerializable()
class Chat {
  @JsonKey(name: "SCC")
  bool scc;
  @JsonKey(name: "SID")
  String? sid;
  @JsonKey(name: "chat")
  ChatClass chat;
  @JsonKey(name: "chatID")
  String chatId;
  @JsonKey(name: "user")
  Opposition user;
  @JsonKey(name: "opposition")
  Opposition opposition;

  Chat({
    required this.scc,
    required this.sid,
    required this.chat,
    required this.chatId,
    required this.user,
    required this.opposition,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable()
class ChatClass {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "members")
  List<Member> members;
  @JsonKey(name: "createdAt")
  double createdAt;
  @JsonKey(name: "messages")
  List<Message> messages;

  ChatClass({
    required this.id,
    required this.members,
    required this.createdAt,
    required this.messages,
  });

  factory ChatClass.fromJson(Map<String, dynamic> json) =>
      _$ChatClassFromJson(json);

  Map<String, dynamic> toJson() => _$ChatClassToJson(this);
}

@JsonSerializable()
class Member {
  @JsonKey(name: "user")
  String user;
  @JsonKey(name: "profilePicture")
  dynamic profilePicture;

  Member({
    required this.user,
    this.profilePicture,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable()
class Message {
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "sender")
  String sender;
  @JsonKey(name: "receiver")
  String receiver;
  @JsonKey(name: "at")
  double at;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "bookingData")
  As? bookingData;
  Message({
    required this.content,
    required this.image,
    required this.sender,
    required this.receiver,
    required this.at,
    required this.id,
    this.bookingData,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class Opposition {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "dateOfBirth")
  String? dateOfBirth;
  @JsonKey(name: "IPDATA")
  Ipdata? ipdata;
  @JsonKey(name: "fullName")
  String fullName;
  @JsonKey(name: "profileImage")
  dynamic profileImage;
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "lastTimeLoggedIn")
  double lastTimeLoggedIn;
  @JsonKey(name: "ipraw")
  String ipraw;
  @JsonKey(name: "idVerified")
  bool idVerified;
  @JsonKey(name: "thirdParty")
  String thirdParty;
  @JsonKey(name: "backPhotoID")
  String? backPhotoId;
  @JsonKey(name: "deliveryAddress")
  String? deliveryAddress;
  @JsonKey(name: "photoOfId")
  String? photoOfId;
  @JsonKey(name: "inbox")
  List<String> inbox;

  Opposition({
    required this.id,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.ipdata,
    required this.fullName,
    this.profileImage,
    required this.phoneNumber,
    required this.lastTimeLoggedIn,
    required this.ipraw,
    required this.idVerified,
    required this.thirdParty,
    this.backPhotoId,
    this.deliveryAddress,
    this.photoOfId,
    required this.inbox,
  });

  factory Opposition.fromJson(Map<String, dynamic> json) =>
      _$OppositionFromJson(json);

  Map<String, dynamic> toJson() => _$OppositionToJson(this);
}

@JsonSerializable()
class Ipdata {
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "country")
  String country;
  @JsonKey(name: "countryCode")
  String countryCode;
  @JsonKey(name: "region")
  String region;
  @JsonKey(name: "regionName")
  String regionName;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "zip")
  String zip;
  @JsonKey(name: "lat")
  double lat;
  @JsonKey(name: "lon")
  double lon;
  @JsonKey(name: "timezone")
  String timezone;
  @JsonKey(name: "isp")
  String isp;
  @JsonKey(name: "org")
  String org;
  @JsonKey(name: "as")
  String ipdataAs;
  @JsonKey(name: "query")
  String query;

  Ipdata({
    required this.status,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.isp,
    required this.org,
    required this.ipdataAs,
    required this.query,
  });

  factory Ipdata.fromJson(Map<String, dynamic> json) => _$IpdataFromJson(json);

  Map<String, dynamic> toJson() => _$IpdataToJson(this);
}
