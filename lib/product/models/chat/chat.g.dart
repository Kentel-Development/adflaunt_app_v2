// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      scc: json['SCC'] as bool,
      sid: json['SID'] as String,
      chat: ChatClass.fromJson(json['chat'] as Map<String, dynamic>),
      chatId: json['chatID'] as String,
      user: Opposition.fromJson(json['user'] as Map<String, dynamic>),
      opposition:
          Opposition.fromJson(json['opposition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'SCC': instance.scc,
      'SID': instance.sid,
      'chat': instance.chat,
      'chatID': instance.chatId,
      'user': instance.user,
      'opposition': instance.opposition,
    };

ChatClass _$ChatClassFromJson(Map<String, dynamic> json) => ChatClass(
      id: json['_id'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: (json['createdAt'] as num).toDouble(),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatClassToJson(ChatClass instance) => <String, dynamic>{
      '_id': instance.id,
      'members': instance.members,
      'createdAt': instance.createdAt,
      'messages': instance.messages,
    };

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      user: json['user'] as String,
      profilePicture: json['profilePicture'],
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'user': instance.user,
      'profilePicture': instance.profilePicture,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      content: json['content'] as String,
      image: json['image'] as String,
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
      at: (json['at'] as num).toDouble(),
      id: json['_id'] as String,
      bookingData: json['bookingData'] == null
          ? null
          : As.fromJson(json['bookingData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'content': instance.content,
      'image': instance.image,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'at': instance.at,
      '_id': instance.id,
      'bookingData': instance.bookingData,
    };

Opposition _$OppositionFromJson(Map<String, dynamic> json) => Opposition(
      id: json['_id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      ipdata: Ipdata.fromJson(json['IPDATA'] as Map<String, dynamic>),
      fullName: json['fullName'] as String,
      profileImage: json['profileImage'],
      phoneNumber: json['phoneNumber'] as String,
      lastTimeLoggedIn: (json['lastTimeLoggedIn'] as num).toDouble(),
      ipraw: json['ipraw'] as String,
      idVerified: json['idVerified'] as bool,
      thirdParty: json['thirdParty'] as String,
      backPhotoId: json['backPhotoID'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      photoOfId: json['photoOfId'] as String?,
      inbox: (json['inbox'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OppositionToJson(Opposition instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'dateOfBirth': instance.dateOfBirth,
      'IPDATA': instance.ipdata,
      'fullName': instance.fullName,
      'profileImage': instance.profileImage,
      'phoneNumber': instance.phoneNumber,
      'lastTimeLoggedIn': instance.lastTimeLoggedIn,
      'ipraw': instance.ipraw,
      'idVerified': instance.idVerified,
      'thirdParty': instance.thirdParty,
      'backPhotoID': instance.backPhotoId,
      'deliveryAddress': instance.deliveryAddress,
      'photoOfId': instance.photoOfId,
      'inbox': instance.inbox,
    };

Ipdata _$IpdataFromJson(Map<String, dynamic> json) => Ipdata(
      status: json['status'] as String,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      region: json['region'] as String,
      regionName: json['regionName'] as String,
      city: json['city'] as String,
      zip: json['zip'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      timezone: json['timezone'] as String,
      isp: json['isp'] as String,
      org: json['org'] as String,
      ipdataAs: json['as'] as String,
      query: json['query'] as String,
    );

Map<String, dynamic> _$IpdataToJson(Ipdata instance) => <String, dynamic>{
      'status': instance.status,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'region': instance.region,
      'regionName': instance.regionName,
      'city': instance.city,
      'zip': instance.zip,
      'lat': instance.lat,
      'lon': instance.lon,
      'timezone': instance.timezone,
      'isp': instance.isp,
      'org': instance.org,
      'as': instance.ipdataAs,
      'query': instance.query,
    };
