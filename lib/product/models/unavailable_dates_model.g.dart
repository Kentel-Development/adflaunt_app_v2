// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unavailable_dates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnavailableDatesModel _$UnavailableDatesModelFromJson(
        Map<String, dynamic> json) =>
    UnavailableDatesModel(
      scc: json['SCC'] as bool?,
      output:
          (json['output'] as List<dynamic>?)?.map((e) => e as String).toList(),
      printFee: json['printFee'] as int?,
    );

Map<String, dynamic> _$UnavailableDatesModelToJson(
        UnavailableDatesModel instance) =>
    <String, dynamic>{
      'SCC': instance.scc,
      'output': instance.output,
      'printFee': instance.printFee,
    };
