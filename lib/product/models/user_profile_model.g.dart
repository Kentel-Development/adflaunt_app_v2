// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      listings: (json['listings'] as List<dynamic>?)
          ?.map((e) => Listing.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfReviews: (json['numberOfReviews'] as num?)?.toDouble(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      yearsOfHosting: json['yearsOfHosting'] as String?,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'averageRating': instance.averageRating,
      'listings': instance.listings,
      'numberOfReviews': instance.numberOfReviews,
      'user': instance.user,
      'yearsOfHosting': instance.yearsOfHosting,
    };

Listing _$ListingFromJson(Map<String, dynamic> json) => Listing(
      bookingImportUrl: json['BookingImportURL'] as String?,
      bookings: (json['Bookings'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      id: json['_id'] as String?,
      address: json['address'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      bookingNote: json['bookingNote'] as String?,
      bookingOffset: (json['bookingOffset'] as num?)?.toDouble(),
      bookingWindow: (json['bookingWindow'] as num?)?.toDouble(),
      cancel: json['cancel'] as bool?,
      checkIn: json['check_in'] as String?,
      checkOut: json['check_out'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      description: json['description'] as String?,
      extras: json['extras'] as List<dynamic>?,
      height: (json['height'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      inchFootage: (json['inchFootage'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      location: json['location'] as String?,
      long: (json['long'] as num?)?.toDouble(),
      minimumBookingDuration:
          (json['minimumBookingDuration'] as num?)?.toDouble(),
      numberOfReviews: (json['numberOfReviews'] as num?)?.toDouble(),
      population: (json['population'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      requirements: json['requirements'] == null
          ? null
          : Requirements.fromJson(json['requirements'] as Map<String, dynamic>),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      revisionLimit: json['revision_limit'] as String?,
      sqfeet: (json['sqfeet'] as num?)?.toDouble(),
      sqfootage: (json['sqfootage'] as num?)?.toDouble(),
      state: json['state'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      title: json['title'] as String?,
      type: json['type'] as String?,
      typeOfAdd: json['typeOfAdd'] as String?,
      user: json['user'] as String?,
      width: (json['width'] as num?)?.toDouble(),
      zipCode: json['zipCode'] as String?,
    );

Map<String, dynamic> _$ListingToJson(Listing instance) => <String, dynamic>{
      'BookingImportURL': instance.bookingImportUrl,
      'Bookings': instance.bookings?.map((e) => e.toIso8601String()).toList(),
      '_id': instance.id,
      'address': instance.address,
      'averageRating': instance.averageRating,
      'bookingNote': instance.bookingNote,
      'bookingOffset': instance.bookingOffset,
      'bookingWindow': instance.bookingWindow,
      'cancel': instance.cancel,
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
      'reviews': instance.reviews,
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
      'zipCode': instance.zipCode,
    };

Requirements _$RequirementsFromJson(Map<String, dynamic> json) =>
    Requirements();

Map<String, dynamic> _$RequirementsToJson(Requirements instance) =>
    <String, dynamic>{};

User _$UserFromJson(Map<String, dynamic> json) => User(
      ipdata: json['IPDATA'] == null
          ? null
          : Ipdata.fromJson(json['IPDATA'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      backPhotoId: json['backPhotoID'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      idVerified: json['idVerified'] as bool?,
      inbox:
          (json['inbox'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ipraw: json['ipraw'] as String?,
      lastTimeLoggedIn: (json['lastTimeLoggedIn'] as num?)?.toDouble(),
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      phoneNumber: json['phoneNumber'] as String?,
      photoOfId: json['photoOfId'] as String?,
      profileImage: json['profileImage'] as String?,
      stripeCustomerId: json['stripeCustomerID'] as String?,
      thirdParty: json['thirdParty'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      balance: (json['balance'] as num?)?.toDouble(),
      password: json['password'] as String?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'IPDATA': instance.ipdata,
      '_id': instance.id,
      'backPhotoID': instance.backPhotoId,
      'dateOfBirth': instance.dateOfBirth,
      'deliveryAddress': instance.deliveryAddress,
      'email': instance.email,
      'fullName': instance.fullName,
      'idVerified': instance.idVerified,
      'inbox': instance.inbox,
      'ipraw': instance.ipraw,
      'lastTimeLoggedIn': instance.lastTimeLoggedIn,
      'orders': instance.orders,
      'phoneNumber': instance.phoneNumber,
      'photoOfId': instance.photoOfId,
      'profileImage': instance.profileImage,
      'stripeCustomerID': instance.stripeCustomerId,
      'thirdParty': instance.thirdParty,
      'lat': instance.lat,
      'long': instance.long,
      'balance': instance.balance,
      'password': instance.password,
      'reviews': instance.reviews,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      at: (json['at'] as num?)?.toDouble(),
      customer: json['customer'] == null
          ? null
          : User.fromJson(json['customer'] as Map<String, dynamic>),
      host: json['host'] as String?,
      listing: json['listing'] as String?,
      revenue: (json['revenue'] as num?)?.toDouble(),
      review: json['review'] as String?,
      star: (json['star'] as num?)?.toDouble(),
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

Ipdata _$IpdataFromJson(Map<String, dynamic> json) => Ipdata(
      ipdataAs: json['as'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
      isp: json['isp'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      org: json['org'] as String?,
      query: json['query'] as String?,
      region: json['region'] as String?,
      regionName: json['regionName'] as String?,
      status: json['status'] as String?,
      timezone: json['timezone'] as String?,
      zip: json['zip'] as String?,
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
      bookingId: json['bookingID'] as String?,
      customer: json['customer'] as String?,
      daysWantToBook: (json['daysWantToBook'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      description: json['description'] as String?,
      paymentId: json['paymentID'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      pricePerDay: (json['pricePerDay'] as num?)?.toDouble(),
      printingFile: json['printingFile'] as String?,
      timeStamp: (json['timeStamp'] as num?)?.toDouble(),
      title: json['title'] as String?,
      proofs:
          (json['proofs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'bookingID': instance.bookingId,
      'customer': instance.customer,
      'daysWantToBook':
          instance.daysWantToBook?.map((e) => e.toIso8601String()).toList(),
      'description': instance.description,
      'paymentID': instance.paymentId,
      'price': instance.price,
      'pricePerDay': instance.pricePerDay,
      'printingFile': instance.printingFile,
      'timeStamp': instance.timeStamp,
      'title': instance.title,
      'proofs': instance.proofs,
    };
