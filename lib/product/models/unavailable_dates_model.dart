// To parse this JSON data, do
//
//     final unavailableDatesModel = unavailableDatesModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'unavailable_dates_model.g.dart';

String unavailableDatesModelToJson(UnavailableDatesModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class UnavailableDatesModel {
  @JsonKey(name: "SCC")
  bool? scc;
  @JsonKey(name: "output")
  List<String>? output;
  @JsonKey(name: "printFee")
  int? printFee;

  UnavailableDatesModel({
    this.scc,
    this.output,
    this.printFee,
  });

  factory UnavailableDatesModel.fromJson(Map<String, dynamic> json) =>
      _$UnavailableDatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnavailableDatesModelToJson(this);
}
