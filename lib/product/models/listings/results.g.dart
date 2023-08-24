// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      scc: json['SCC'] as bool,
      output: (json['output'] as List<dynamic>)
          .map((e) => Output.fromJson(e as Map<String, dynamic>))
          .toList(),
      sid: json['sid'] as String?,
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'SCC': instance.scc,
      'output': instance.output,
      'sid': instance.sid,
    };

Output _$OutputFromJson(Map<String, dynamic> json) => Output(
      zipCode: json['zipCode'] as String,
      bookingImportUrl: json['BookingImportURL'] as String,
      bookings: (json['Bookings'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      id: json['_id'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      bookingNote: json['bookingNote'] as String,
      bookingOffset: json['bookingOffset'] as int,
      bookingWindow: json['bookingWindow'] as int,
      checkIn: json['check_in'] as String,
      checkOut: json['check_out'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      description: json['description'] as String,
      cancel: json['cancel'] as bool?,
      extras: json['extras'] as List<dynamic>,
      height: (json['height'] as num).toDouble(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      inchFootage: (json['inchFootage'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      location: json['location'] as String,
      long: (json['long'] as num).toDouble(),
      minimumBookingDuration: json['minimumBookingDuration'] as int,
      numberOfReviews: json['numberOfReviews'] as int?,
      population: json['population'] as int,
      price: (json['price'] as num).toDouble(),
      requirements:
          Requirements.fromJson(json['requirements'] as Map<String, dynamic>),
      revisionLimit: json['revision_limit'] as String,
      sqfeet: (json['sqfeet'] as num).toDouble(),
      sqfootage: (json['sqfootage'] as num).toDouble(),
      state: json['state'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      title: json['title'] as String,
      type: json['type'] as String,
      typeOfAdd: json['typeOfAdd'] as String,
      user: json['user'] as String,
      width: (json['width'] as num).toDouble(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OutputToJson(Output instance) => <String, dynamic>{
      'zipCode': instance.zipCode,
      'BookingImportURL': instance.bookingImportUrl,
      'Bookings': instance.bookings?.map((e) => e.toIso8601String()).toList(),
      '_id': instance.id,
      'averageRating': instance.averageRating,
      'bookingNote': instance.bookingNote,
      'bookingOffset': instance.bookingOffset,
      'bookingWindow': instance.bookingWindow,
      'check_in': instance.checkIn,
      'check_out': instance.checkOut,
      'city': instance.city,
      'country': instance.country,
      'description': instance.description,
      'extras': instance.extras,
      'height': instance.height,
      'images': instance.images,
      'inchFootage': instance.inchFootage,
      'lat': instance.lat,
      'location': instance.location,
      'long': instance.long,
      'minimumBookingDuration': instance.minimumBookingDuration,
      'numberOfReviews': instance.numberOfReviews,
      'population': instance.population,
      'price': instance.price,
      'requirements': instance.requirements,
      'revision_limit': instance.revisionLimit,
      'sqfeet': instance.sqfeet,
      'sqfootage': instance.sqfootage,
      'state': instance.state,
      'tags': instance.tags,
      'title': instance.title,
      'type': instance.type,
      'typeOfAdd': instance.typeOfAdd,
      'user': instance.user,
      'width': instance.width,
      'reviews': instance.reviews,
      'cancel': instance.cancel,
    };

Requirements _$RequirementsFromJson(Map<String, dynamic> json) =>
    Requirements();

Map<String, dynamic> _$RequirementsToJson(Requirements instance) =>
    <String, dynamic>{};

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      at: (json['at'] as num).toDouble(),
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      host: json['host'] as String,
      listing: json['listing'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      review: json['review'] as String,
      star: (json['star'] as num).toDouble(),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'at': instance.at,
      'customer': instance.customer,
      'host': instance.host,
      'listing': instance.listing,
      'revenue': instance.revenue,
      'review': instance.review,
      'star': instance.star,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      ipdata: Ipdata.fromJson(json['IPDATA'] as Map<String, dynamic>),
      id: json['_id'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      idVerified: json['idVerified'] as bool?,
      ipraw: json['ipraw'] as String?,
      lastTimeLoggedIn: (json['lastTimeLoggedIn'] as num).toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      phoneNumber: json['phoneNumber'] as String?,
      profileImage: json['profileImage'],
      stripeCustomerId: json['stripeCustomerID'] as String?,
      thirdParty: json['thirdParty'] as String,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'IPDATA': instance.ipdata,
      '_id': instance.id,
      'dateOfBirth': instance.dateOfBirth,
      'email': instance.email,
      'fullName': instance.fullName,
      'idVerified': instance.idVerified,
      'ipraw': instance.ipraw,
      'lastTimeLoggedIn': instance.lastTimeLoggedIn,
      'lat': instance.lat,
      'long': instance.long,
      'orders': instance.orders,
      'phoneNumber': instance.phoneNumber,
      'profileImage': instance.profileImage,
      'stripeCustomerID': instance.stripeCustomerId,
      'thirdParty': instance.thirdParty,
    };

Ipdata _$IpdataFromJson(Map<String, dynamic> json) => Ipdata(
      ipdataAs: json['as'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      isp: json['isp'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      org: json['org'] as String,
      query: json['query'] as String,
      region: json['region'] as String,
      regionName: json['regionName'] as String,
      status: json['status'] as String,
      timezone: json['timezone'] as String,
      zip: json['zip'] as String,
    );

Map<String, dynamic> _$IpdataToJson(Ipdata instance) => <String, dynamic>{
      'as': instance.ipdataAs,
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

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      bookingId: json['bookingID'] as String,
      customer: json['customer'] as String,
      daysWantToBook: (json['daysWantToBook'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      description: json['description'] as String,
      paymentId: json['paymentID'] as String,
      price: (json['price'] as num).toDouble(),
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      printingFile: json['printingFile'],
      timeStamp: (json['timeStamp'] as num).toDouble(),
      title: json['title'] as String,
      proofs:
          (json['proofs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'bookingID': instance.bookingId,
      'customer': instance.customer,
      'daysWantToBook':
          instance.daysWantToBook.map((e) => e.toIso8601String()).toList(),
      'description': instance.description,
      'paymentID': instance.paymentId,
      'price': instance.price,
      'pricePerDay': instance.pricePerDay,
      'printingFile': instance.printingFile,
      'timeStamp': instance.timeStamp,
      'title': instance.title,
      'proofs': instance.proofs,
    };
