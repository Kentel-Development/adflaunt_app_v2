// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_with_profile_images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingsWithProfileImages _$BookingsWithProfileImagesFromJson(
        Map<String, dynamic> json) =>
    BookingsWithProfileImages(
      scc: json['SCC'] as bool?,
      output: (json['output'] as List<dynamic>?)
          ?.map((e) => Output.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingsWithProfileImagesToJson(
        BookingsWithProfileImages instance) =>
    <String, dynamic>{
      'SCC': instance.scc,
      'output': instance.output,
    };

Output _$OutputFromJson(Map<String, dynamic> json) => Output(
      customer: json['customer'] as String?,
      daysWantToBook: (json['daysWantToBook'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      profileImage: json['profileImage'],
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OutputToJson(Output instance) => <String, dynamic>{
      'customer': instance.customer,
      'daysWantToBook':
          instance.daysWantToBook?.map((e) => e.toIso8601String()).toList(),
      'profileImage': instance.profileImage,
      'status': instance.status,
    };
