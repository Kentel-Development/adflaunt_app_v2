// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      ipdata: json['ipdata'] == null
          ? null
          : Ipdata.fromJson(json['ipdata'] as Map<String, dynamic>),
      id: json['id'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      idVerified: json['idVerified'] as bool?,
      ipraw: json['ipraw'] as String?,
      lastTimeLoggedIn: (json['lastTimeLoggedIn'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Orders.fromJson(e as Map<String, dynamic>))
          .toList(),
      phoneNumber: json['phoneNumber'] as String?,
      profileImage: json['profileImage'] as String?,
      stripeCustomerID: json['stripeCustomerID'] as String?,
      thirdParty: json['thirdParty'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'ipdata': instance.ipdata,
      'id': instance.id,
      'dateOfBirth': instance.dateOfBirth,
      'email': instance.email,
      'fullName': instance.fullName,
      'idVerified': instance.idVerified,
      'ipraw': instance.ipraw,
      'lastTimeLoggedIn': instance.lastTimeLoggedIn,
      'lat': instance.lat,
      'long': instance.long,
      'orders': instance.orders,
      'phoneNumber': instance.phoneNumber,
      'profileImage': instance.profileImage,
      'stripeCustomerID': instance.stripeCustomerID,
      'thirdParty': instance.thirdParty,
    };
