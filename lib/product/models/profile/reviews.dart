import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'customer.dart';
part 'reviews.g.dart';

@JsonSerializable()
class Reviews with EquatableMixin {
  double? at;
  Customer? customer;
  String? host;
  String? listing;
  double? revenue;
  String? review;
  double? star;

  Reviews({
    this.at,
    this.customer,
    this.host,
    this.listing,
    this.revenue,
    this.review,
    this.star,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsToJson(this);

  @override
  List<Object?> get props =>
      [at, customer, host, listing, revenue, review, star];

  Reviews copyWith({
    double? at,
    Customer? customer,
    String? host,
    String? listing,
    double? revenue,
    String? review,
    double? star,
  }) {
    return Reviews(
      at: at ?? this.at,
      customer: customer ?? this.customer,
      host: host ?? this.host,
      listing: listing ?? this.listing,
      revenue: revenue ?? this.revenue,
      review: review ?? this.review,
      star: star ?? this.star,
    );
  }
}
