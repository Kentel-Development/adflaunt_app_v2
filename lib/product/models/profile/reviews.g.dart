// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
      at: (json['at'] as num?)?.toDouble(),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      host: json['host'] as String?,
      listing: json['listing'] as String?,
      revenue: (json['revenue'] as num?)?.toDouble(),
      review: json['review'] as String?,
      star: (json['star'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'at': instance.at,
      'customer': instance.customer,
      'host': instance.host,
      'listing': instance.listing,
      'revenue': instance.revenue,
      'review': instance.review,
      'star': instance.star,
    };
