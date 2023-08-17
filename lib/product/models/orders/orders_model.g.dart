// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel(
      scc: json['SCC'] as bool?,
      asCustomer: (json['asCustomer'] as List<dynamic>?)
          ?.map((e) => As.fromJson(e as Map<String, dynamic>))
          .toList(),
      asHost: (json['asHost'] as List<dynamic>?)
          ?.map((e) => As.fromJson(e as Map<String, dynamic>))
          .toList(),
      userData: json['userData'] == null
          ? null
          : UserData.fromJson(json['userData'] as Map<String, dynamic>),
      userType: json['user_type'] as String?,
    );

Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
    <String, dynamic>{
      'SCC': instance.scc,
      'asCustomer': instance.asCustomer,
      'asHost': instance.asHost,
      'userData': instance.userData,
      'user_type': instance.userType,
    };

As _$AsFromJson(Map<String, dynamic> json) => As(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      listingData: json['listingData'] == null
          ? null
          : ListingData.fromJson(json['listingData'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AsToJson(As instance) => <String, dynamic>{
      'data': instance.data,
      'listingData': instance.listingData,
      'status': instance.status,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      bookingId: json['bookingID'] as String?,
      clickAction: json['click_action'] as String?,
      customer: json['customer'] as String?,
      daysWantToBook: (json['daysWantToBook'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      description: json['description'] as String?,
      page: json['page'] as String?,
      paymentId: json['paymentID'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      pricePerDay: (json['pricePerDay'] as num?)?.toDouble(),
      printingFile: json['printingFile'],
      timeStamp: (json['timeStamp'] as num?)?.toDouble(),
      title: json['title'] as String?,
      proofs:
          (json['proofs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'bookingID': instance.bookingId,
      'click_action': instance.clickAction,
      'customer': instance.customer,
      'daysWantToBook':
          instance.daysWantToBook?.map((e) => e.toIso8601String()).toList(),
      'description': instance.description,
      'page': instance.page,
      'paymentID': instance.paymentId,
      'price': instance.price,
      'pricePerDay': instance.pricePerDay,
      'printingFile': instance.printingFile,
      'timeStamp': instance.timeStamp,
      'title': instance.title,
      'proofs': instance.proofs,
    };

ListingData _$ListingDataFromJson(Map<String, dynamic> json) => ListingData(
      bookingImportUrl: json['BookingImportURL'] as String?,
      bookings: (json['Bookings'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      id: json['_id'] as String?,
      address: json['address'] as String?,
      bookingNote: json['bookingNote'] as String?,
      bookingOffset: json['bookingOffset'] as int?,
      bookingWindow: json['bookingWindow'] as int?,
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
      minimumBookingDuration: json['minimumBookingDuration'] as int?,
      population: json['population'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      requirements: json['requirements'] == null
          ? null
          : Requirements.fromJson(json['requirements'] as Map<String, dynamic>),
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

Map<String, dynamic> _$ListingDataToJson(ListingData instance) =>
    <String, dynamic>{
      'BookingImportURL': instance.bookingImportUrl,
      'Bookings': instance.bookings?.map((e) => e.toIso8601String()).toList(),
      '_id': instance.id,
      'address': instance.address,
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
      'zipCode': instance.zipCode,
    };

Requirements _$RequirementsFromJson(Map<String, dynamic> json) =>
    Requirements();

Map<String, dynamic> _$RequirementsToJson(Requirements instance) =>
    <String, dynamic>{};

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
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
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      password: json['password'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoOfId: json['photoOfId'] as String?,
      profileImage: json['profileImage'] as String?,
      stripeCustomerId: json['stripeCustomerID'] as String?,
      thirdParty: json['thirdParty'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
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
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'photoOfId': instance.photoOfId,
      'profileImage': instance.profileImage,
      'stripeCustomerID': instance.stripeCustomerId,
      'thirdParty': instance.thirdParty,
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
