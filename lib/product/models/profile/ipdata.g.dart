// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ipdata _$IpdataFromJson(Map<String, dynamic> json) => Ipdata(
      asProperty: json['asProperty'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
      isp: json['isp'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      org: json['org'] as String?,
      query: json['query'] as String?,
      region: json['region'] as String?,
      regionName: json['regionName'] as String?,
      status: json['status'] as String?,
      timezone: json['timezone'] as String?,
      zip: json['zip'] as String?,
    );

Map<String, dynamic> _$IpdataToJson(Ipdata instance) => <String, dynamic>{
      'asProperty': instance.asProperty,
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
