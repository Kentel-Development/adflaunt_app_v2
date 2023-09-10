// To parse this JSON data, do
//
//     final inbox = inboxFromJson(jsonString);

import 'package:adflaunt/product/models/orders/orders_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'inbox.g.dart';

String inboxToJson(Inbox data) => json.encode(data.toJson());

@JsonSerializable()
class Inbox {
  @JsonKey(name: "SCC")
  bool scc;
  @JsonKey(name: "output")
  List<ChatOutput> chatOutput;

  Inbox({
    required this.scc,
    required this.chatOutput,
  });

  factory Inbox.fromJson(Map<String, dynamic> json) => _$InboxFromJson(json);

  Map<String, dynamic> toJson() => _$InboxToJson(this);
}

@JsonSerializable()
class ChatOutput {
  @JsonKey(name: "chatID")
  String chatId;
  @JsonKey(name: "lastMessage")
  dynamic lastMessage;
  @JsonKey(name: "lastMessageTime")
  double lastMessageTime;
  @JsonKey(name: "them")
  Them them;
  @JsonKey(name: "unreadMessages")
  int? unreadMessages;
  ChatOutput({
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.them,
    this.unreadMessages,
  });

  factory ChatOutput.fromJson(Map<String, dynamic> json) =>
      _$ChatOutputFromJson(json);

  Map<String, dynamic> toJson() => _$ChatOutputToJson(this);
}

@JsonSerializable()
class LastMessageClass {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "at")
  double at;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "image", defaultValue: "")
  String image;
  @JsonKey(name: "receiver")
  String receiver;
  @JsonKey(name: "sender")
  String sender;
  @JsonKey(name: "bookingData")
  As? bookingData;

  LastMessageClass({
    required this.id,
    required this.at,
    required this.content,
    required this.image,
    required this.receiver,
    required this.sender,
    this.bookingData,
  });

  factory LastMessageClass.fromJson(Map<String, dynamic> json) =>
      _$LastMessageClassFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessageClassToJson(this);
}

@JsonSerializable()
class Them {
  @JsonKey(name: "IPDATA", includeIfNull: false)
  Ipdata ipdata;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "backPhotoID", includeIfNull: false)
  String? backPhotoId;
  @JsonKey(name: "dateOfBirth", includeIfNull: false)
  String? dateOfBirth;
  @JsonKey(name: "deliveryAddress", includeIfNull: false)
  String? deliveryAddress;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "fullName")
  String fullName;
  @JsonKey(name: "idVerified")
  bool idVerified;
  @JsonKey(name: "inbox", includeIfNull: false)
  List<String> inbox;
  @JsonKey(name: "ipraw", includeIfNull: false)
  String ipraw;
  @JsonKey(name: "lastTimeLoggedIn", includeIfNull: false)
  double lastTimeLoggedIn;
  @JsonKey(name: "phoneNumber", includeIfNull: false)
  String? phoneNumber;
  @JsonKey(name: "photoOfId", includeIfNull: false)
  String? photoOfId;
  @JsonKey(name: "profileImage", includeIfNull: false)
  dynamic profileImage;
  @JsonKey(name: "thirdParty", includeIfNull: false)
  String thirdParty;

  Them({
    required this.ipdata,
    required this.id,
    required this.backPhotoId,
    required this.dateOfBirth,
    required this.deliveryAddress,
    required this.email,
    required this.fullName,
    required this.idVerified,
    required this.inbox,
    required this.ipraw,
    required this.lastTimeLoggedIn,
    required this.phoneNumber,
    required this.photoOfId,
    this.profileImage,
    required this.thirdParty,
  });

  factory Them.fromJson(Map<String, dynamic> json) => _$ThemFromJson(json);

  Map<String, dynamic> toJson() => _$ThemToJson(this);
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
