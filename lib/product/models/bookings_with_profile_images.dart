// To parse this JSON data, do
//
//     final bookingsWithProfileImages = bookingsWithProfileImagesFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'bookings_with_profile_images.g.dart';

String bookingsWithProfileImagesToJson(BookingsWithProfileImages data) =>
    json.encode(data.toJson());

@JsonSerializable()
class BookingsWithProfileImages {
  @JsonKey(name: "SCC")
  bool? scc;
  @JsonKey(name: "output")
  List<Output>? output;

  BookingsWithProfileImages({
    this.scc,
    this.output,
  });

  factory BookingsWithProfileImages.fromJson(Map<String, dynamic> json) =>
      _$BookingsWithProfileImagesFromJson(json);

  Map<String, dynamic> toJson() => _$BookingsWithProfileImagesToJson(this);
}

@JsonSerializable()
class Output {
  @JsonKey(name: "customer")
  String? customer;
  @JsonKey(name: "daysWantToBook")
  List<DateTime>? daysWantToBook;
  @JsonKey(name: "profileImage")
  dynamic profileImage;
  @JsonKey(name: "status")
  String? status;

  Output({
    this.customer,
    this.daysWantToBook,
    this.profileImage,
    this.status,
  });

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  Map<String, dynamic> toJson() => _$OutputToJson(this);
}
