// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      ipdata: json['ipdata'] == null
          ? null
          : Ipdata.fromJson(json['ipdata'] as Map<String, dynamic>),
      scc: json['scc'] as bool?,
      id: json['id'] as String?,
      backPhotoID: json['backPhotoID'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      dateOfBirth: json['dateOfBirth'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      idVerified: json['idVerified'] as bool?,
      ipraw: json['ipraw'] as String?,
      lastTimeLoggedIn: (json['lastTimeLoggedIn'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      password: json['password'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoOfId: json['photoOfId'] as String?,
      profileImage: json['profileImage'] as String?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Reviews.fromJson(e as Map<String, dynamic>))
          .toList(),
      thirdParty: json['thirdParty'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'ipdata': instance.ipdata,
      'scc': instance.scc,
      'id': instance.id,
      'backPhotoID': instance.backPhotoID,
      'balance': instance.balance,
      'dateOfBirth': instance.dateOfBirth,
      'deliveryAddress': instance.deliveryAddress,
      'email': instance.email,
      'fullName': instance.fullName,
      'idVerified': instance.idVerified,
      'ipraw': instance.ipraw,
      'lastTimeLoggedIn': instance.lastTimeLoggedIn,
      'lat': instance.lat,
      'long': instance.long,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'photoOfId': instance.photoOfId,
      'profileImage': instance.profileImage,
      'reviews': instance.reviews,
      'thirdParty': instance.thirdParty,
    };
