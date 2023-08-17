import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'orders.g.dart';

@JsonSerializable()
class Orders with EquatableMixin {
  String? bookingID;
  String? customer;
  List<String>? daysWantToBook;
  String? description;
  String? paymentID;
  int? price;
  int? pricePerDay;
  String? printingFile;
  double? timeStamp;
  String? title;
  List<String>? proofs;

  Orders({
    this.bookingID,
    this.customer,
    this.daysWantToBook,
    this.description,
    this.paymentID,
    this.price,
    this.pricePerDay,
    this.printingFile,
    this.timeStamp,
    this.title,
    this.proofs,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);

  @override
  List<Object?> get props => [
        bookingID,
        customer,
        daysWantToBook,
        description,
        paymentID,
        price,
        pricePerDay,
        printingFile,
        timeStamp,
        title,
        proofs
      ];

  Orders copyWith({
    String? bookingID,
    String? customer,
    List<String>? daysWantToBook,
    String? description,
    String? paymentID,
    int? price,
    int? pricePerDay,
    String? printingFile,
    double? timeStamp,
    String? title,
    List<String>? proofs,
  }) {
    return Orders(
      bookingID: bookingID ?? this.bookingID,
      customer: customer ?? this.customer,
      daysWantToBook: daysWantToBook ?? this.daysWantToBook,
      description: description ?? this.description,
      paymentID: paymentID ?? this.paymentID,
      price: price ?? this.price,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      printingFile: printingFile ?? this.printingFile,
      timeStamp: timeStamp ?? this.timeStamp,
      title: title ?? this.title,
      proofs: proofs ?? this.proofs,
    );
  }
}
