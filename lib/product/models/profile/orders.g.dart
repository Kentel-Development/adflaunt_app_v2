// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      bookingID: json['bookingID'] as String?,
      customer: json['customer'] as String?,
      daysWantToBook: (json['daysWantToBook'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      paymentID: json['paymentID'] as String?,
      price: json['price'] as int?,
      pricePerDay: json['pricePerDay'] as int?,
      printingFile: json['printingFile'] as String?,
      timeStamp: (json['timeStamp'] as num?)?.toDouble(),
      title: json['title'] as String?,
      proofs:
          (json['proofs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'bookingID': instance.bookingID,
      'customer': instance.customer,
      'daysWantToBook': instance.daysWantToBook,
      'description': instance.description,
      'paymentID': instance.paymentID,
      'price': instance.price,
      'pricePerDay': instance.pricePerDay,
      'printingFile': instance.printingFile,
      'timeStamp': instance.timeStamp,
      'title': instance.title,
      'proofs': instance.proofs,
    };
