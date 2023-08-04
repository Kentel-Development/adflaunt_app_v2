import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'ipdata.g.dart';

@JsonSerializable()
class Ipdata with EquatableMixin {
  String? asProperty;
  String? city;
  String? country;
  String? countryCode;
  String? isp;
  double? lat;
  double? lon;
  String? org;
  String? query;
  String? region;
  String? regionName;
  String? status;
  String? timezone;
  String? zip;

  Ipdata({
    this.asProperty,
    this.city,
    this.country,
    this.countryCode,
    this.isp,
    this.lat,
    this.lon,
    this.org,
    this.query,
    this.region,
    this.regionName,
    this.status,
    this.timezone,
    this.zip,
  });

  factory Ipdata.fromJson(Map<String, dynamic> json) => _$IpdataFromJson(json);

  Map<String, dynamic> toJson() => _$IpdataToJson(this);

  @override
  List<Object?> get props => [
        asProperty,
        city,
        country,
        countryCode,
        isp,
        lat,
        lon,
        org,
        query,
        region,
        regionName,
        status,
        timezone,
        zip
      ];

  Ipdata copyWith({
    String? asProperty,
    String? city,
    String? country,
    String? countryCode,
    String? isp,
    double? lat,
    double? lon,
    String? org,
    String? query,
    String? region,
    String? regionName,
    String? status,
    String? timezone,
    String? zip,
  }) {
    return Ipdata(
      asProperty: asProperty ?? this.asProperty,
      city: city ?? this.city,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      isp: isp ?? this.isp,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      org: org ?? this.org,
      query: query ?? this.query,
      region: region ?? this.region,
      regionName: regionName ?? this.regionName,
      status: status ?? this.status,
      timezone: timezone ?? this.timezone,
      zip: zip ?? this.zip,
    );
  }
}
