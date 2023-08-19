// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inbox _$InboxFromJson(Map<String, dynamic> json) => Inbox(
      scc: json['SCC'] as bool,
      chatOutput: (json['output'] as List<dynamic>)
          .map((e) => ChatOutput.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InboxToJson(Inbox instance) => <String, dynamic>{
      'SCC': instance.scc,
      'output': instance.chatOutput,
    };

ChatOutput _$ChatOutputFromJson(Map<String, dynamic> json) => ChatOutput(
      chatId: json['chatID'] as String,
      lastMessage: json['lastMessage'],
      lastMessageTime: (json['lastMessageTime'] as num).toDouble(),
      them: Them.fromJson(json['them'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatOutputToJson(ChatOutput instance) =>
    <String, dynamic>{
      'chatID': instance.chatId,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'them': instance.them,
    };

LastMessageClass _$LastMessageClassFromJson(Map<String, dynamic> json) =>
    LastMessageClass(
      id: json['_id'] as String,
      at: (json['at'] as num).toDouble(),
      content: json['content'] as String,
      image: json['image'] as String? ?? '',
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      bookingData: json['bookingData'] == null
          ? null
          : As.fromJson(json['bookingData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LastMessageClassToJson(LastMessageClass instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'at': instance.at,
      'content': instance.content,
      'image': instance.image,
      'receiver': instance.receiver,
      'sender': instance.sender,
      'bookingData': instance.bookingData,
    };

Them _$ThemFromJson(Map<String, dynamic> json) => Them(
      ipdata: Ipdata.fromJson(json['IPDATA'] as Map<String, dynamic>),
      id: json['_id'] as String,
      backPhotoId: json['backPhotoID'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      idVerified: json['idVerified'] as bool,
      inbox: (json['inbox'] as List<dynamic>).map((e) => e as String).toList(),
      ipraw: json['ipraw'] as String,
      lastTimeLoggedIn: (json['lastTimeLoggedIn'] as num).toDouble(),
      phoneNumber: json['phoneNumber'] as String?,
      photoOfId: json['photoOfId'] as String?,
      profileImage: json['profileImage'],
      thirdParty: json['thirdParty'] as String,
    );

Map<String, dynamic> _$ThemToJson(Them instance) {
  final val = <String, dynamic>{
    'IPDATA': instance.ipdata,
    '_id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('backPhotoID', instance.backPhotoId);
  writeNotNull('dateOfBirth', instance.dateOfBirth);
  writeNotNull('deliveryAddress', instance.deliveryAddress);
  val['email'] = instance.email;
  val['fullName'] = instance.fullName;
  val['idVerified'] = instance.idVerified;
  val['inbox'] = instance.inbox;
  val['ipraw'] = instance.ipraw;
  val['lastTimeLoggedIn'] = instance.lastTimeLoggedIn;
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('photoOfId', instance.photoOfId);
  writeNotNull('profileImage', instance.profileImage);
  val['thirdParty'] = instance.thirdParty;
  return val;
}

Ipdata _$IpdataFromJson(Map<String, dynamic> json) => Ipdata(
      ipdataAs: json['as'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      isp: json['isp'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      org: json['org'] as String,
      query: json['query'] as String,
      region: json['region'] as String,
      regionName: json['regionName'] as String,
      status: json['status'] as String,
      timezone: json['timezone'] as String,
      zip: json['zip'] as String,
    );

Map<String, dynamic> _$IpdataToJson(Ipdata instance) => <String, dynamic>{
      'as': instance.ipdataAs,
      'city': instance.city,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'isp': instance.isp,
      'lat': instance.lat,
      'lon': instance.lon,
      'org': instance.org,
      'query': instance.query,
      'region': instance.region,
      'regionName': instance.regionName,
      'status': instance.status,
      'timezone': instance.timezone,
      'zip': instance.zip,
    };
