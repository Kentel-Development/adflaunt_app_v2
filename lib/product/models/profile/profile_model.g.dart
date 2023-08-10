// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      ipdata: Ipdata.fromJson(json['IPDATA'] as Map<String, dynamic>),
      scc: json['SCC'] as bool?,
      id: json['_id'] as String,
      dateOfBirth: json['dateOfBirth'] as String?,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      idVerified: json['idVerified'] as bool,
      ipraw: json['ipraw'] as String,
      lastTimeLoggedIn: (json['lastTimeLoggedIn'] as num?)?.toDouble(),
      password: json['password'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profileImage: json['profileImage'],
      thirdParty: json['thirdParty'] as String,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) {
  final val = <String, dynamic>{
    'IPDATA': instance.ipdata,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SCC', instance.scc);
  val['_id'] = instance.id;
  writeNotNull('dateOfBirth', instance.dateOfBirth);
  val['email'] = instance.email;
  val['fullName'] = instance.fullName;
  val['idVerified'] = instance.idVerified;
  val['ipraw'] = instance.ipraw;
  writeNotNull('lastTimeLoggedIn', instance.lastTimeLoggedIn);
  writeNotNull('password', instance.password);
  writeNotNull('phoneNumber', instance.phoneNumber);
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
