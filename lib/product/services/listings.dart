import 'dart:convert';
import 'dart:developer';
import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ListingsAPI {
  static Future<Output> getListing(String id) async {
    var url = Uri.parse('${StringConstants.baseUrl}/api/listing/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log(response.body);
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final uid = json["user"]["_id"];
      json.remove("user");
      json.addAll({"user": uid});
      return Output.fromJson(json);
    } else {
      log('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load listings');
    }
  }

  static Future<http.Response> editListing(
      String id,
      List<String> images,
      String title,
      String description,
      String price,
      String length,
      String width,
      bool cancel,
      String spaceType,
      String adType,
      List<String> tags,
      DateTime checkIn,
      DateTime checkOut,
      int category,
      String state,
      String city,
      String country,
      String zip,
      Output listing) async {
    final currentUser = Hive.box<ProfileAdapter>("user").get("userData")!;
    var url = Uri.parse('${StringConstants.baseUrl}/api/create/listing');
    final tagsWith = tags;
    tagsWith.insert(0, spaceType);
    tagsWith.insert(1, adType);
    final response = await http.put(url, body: {
      "email": currentUser.email,
      "password": currentUser.password,
      "listingID": id,
      "title": title,
      "description": description,
      "price": price.substring(1),
      "length": length,
      "width": width,
      "cancel": cancel == true ? "1" : "0",
      "tags": tagsWith.join("|-|"),
      "check_in": DateFormat(StringConstants.dateFormat).format(checkIn),
      "check_out": DateFormat(StringConstants.dateFormat).format(checkOut),
      "city": city,
      "state": state,
      "country": country,
      "zip": zip,
      "typeOfAd": category.toString(),
      "images": images.join("|-|"),
      "lat": listing.lat.toString(),
      "long": listing.long.toString(),
      "address": listing.location,
      "location": listing.location,
      "type": listing.type,
      "revision_limit": listing.revisionLimit,
      "digital": listing.cancel.toString(),
      "population": listing.population.toString(),
      "discountAvailable": true.toString(),
      "extras": listing.extras.toString(),
      "requirements": "{}",
      "bookingNote": listing.bookingNote.toString(),
      "bookingOffset": listing.bookingOffset.toString(),
      "bookingWindow": listing.bookingWindow.toString(),
      "BookingImportURL": listing.bookingImportUrl.toString(),
      "minimumBookingDuration": listing.minimumBookingDuration.toString(),
    });
    return response;
  }

  static Future<http.Response> deleteListing(String id) async {
    final currentUser = Hive.box<ProfileAdapter>("user").get("userData")!;
    var url = Uri.parse('${StringConstants.baseUrl}/api/deleteListing/$id');
    final response = await http.post(url, body: {
      "email": currentUser.email,
      "password": currentUser.password,
    });
    return response;
  }

  static Future<List<Output>> getUserListings() async {
    final currentUser = Hive.box<ProfileAdapter>("user").get("userData")!;
    var url = Uri.parse('${StringConstants.baseUrl}/api/get/ListingsOfUser');
    final response = await http.post(url, body: {
      "email": currentUser.email,
      "password": currentUser.password,
    });
    if (response.statusCode == 200) {
      log(response.body);
      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Results.fromJson(data).output;
    } else {
      throw Exception('Failed to load listings');
    }
  }

  static Future<List<Output>> listingsFilterer(
    int? type,
    String? category,
    String? from,
    String? to,
    String? priceStart,
    String? priceEnd,
    String? lat,
    String? lng,
    String? q,
    String? km,
    String? city,
    String? state,
    String? country,
    String? zip,
    DateTime? checkIn,
    DateTime? checkOut,
  ) async {
    try {
      var url =
          Uri.parse('${StringConstants.baseUrl}/api/get/listingsFilterer');
      url = Uri.http(url.authority, url.path, {
        if (type != null) 'type': type.toString(),
        if (category != null) 'category': category,
        if (checkIn != null)
          'from': DateFormat(StringConstants.dateFormat).format(checkIn),
        if (checkOut != null)
          'to': DateFormat(StringConstants.dateFormat).format(checkOut),
        if (from != null) 'minsq': from,
        if (to != null) 'maxsq': to,
        if (city != "" && city != null && city != "null") 'city': city,
        if (state != "" && state != null && city != "null") 'state': state,
        if (country != "" && country != null && city != "null")
          'country': country,
        if (zip != "" && zip != null && city != "null") 'zipCode': zip,
        if (priceStart != null) 'priceStart': priceStart,
        if (priceEnd != null) 'priceEnd': priceEnd,
        if (lat != null) 'lat': lat,
        if (lng != null) 'long': lng,
        if (q != null) 'q': q,
        if (km != null) 'km': km,
      });
      log(url.toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        log(response.body);
        Results data = resultsFromJson(response.body);
        return data.output;
      } else {
        log('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load listings');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to load listings');
    }
  }

  static Future<List<Output>> getPropertiesBySearch(String search) async {
    var url = Uri.parse(
        '${StringConstants.baseUrl}/api/get/listings?mode=search&q=$search');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      log(response.body);
      return Results.fromJson(jsonDecode(response.body) as Map<String, dynamic>)
          .output;
    } else {
      log('Request failed with status: ${response.statusCode}.');
      log(response.body);
      throw Exception('Failed to load album');
    }
  }

  static Future<http.Response> postListing(
      String title,
      String price,
      String lat,
      String long,
      String state,
      String city,
      String country,
      String zip,
      int type_,
      int revisions,
      bool digital,
      String height,
      String width,
      int category,
      String population,
      String discountAvailable,
      String installationDate,
      String removalDate,
      List<String> tags,
      List<XFile> file,
      List<dynamic> extras,
      String requirements,
      String description,
      bool cancelPolicy,
      ProfileAdapter currentUser,
      String spaceType,
      String adType) async {
    var uploadUrl = Uri.parse("${StringConstants.baseUrl}/api/upload");
    String files = "";
    for (var i = 0; i < file.length; i++) {
      var request = http.MultipartRequest("POST", uploadUrl);
      request.files.add(
        http.MultipartFile(
          'file',
          file[i].readAsBytes().asStream(),
          await file[i].length(),
          filename: file[i].path.split('/').last,
        ),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        final data = await http.Response.fromStream(response);
        log(data.body);
        if (i == file.length - 1) {
          files = files +
              (jsonDecode(data.body) as Map<String, dynamic>)["file"]!
                  .toString();
        } else {
          files =
              "${files + (jsonDecode(data.body) as Map<String, dynamic>)["file"]!.toString()}|-|";
        }
      }
    }
    var url = Uri.parse('${StringConstants.baseUrl}/api/create/listing');
    final tagsWith = tags;
    tagsWith.insert(0, spaceType);
    tagsWith.insert(1, adType);
    final location = await placemarkFromCoordinates(
        double.parse(lat), double.parse(long),
        localeIdentifier: "en_US");
    final response = await http.post(url, body: {
      "email": currentUser.email,
      "password": currentUser.password,
      "title": title.toString(),
      "lat": lat.toString(),
      "long": long.toString(),
      "city": city,
      "state": state,
      "country": country,
      "address": location.first.locality!,
      "zip": zip,
      "images": files.toString(),
      "price": price.toString().substring(1),
      "location": location.first.name.toString(),
      "type": 1.toString(),
      "revision_limit": revisions.toString(),
      "digital": cancelPolicy.toString(),
      "length": height.toString(),
      "width": width.toString(),
      "typeOfAd": category.toString(),
      "population": "1",
      "discountAvailable": 2.toString(),
      "cancel": cancelPolicy.toString(),
      "check_in": installationDate.toString(),
      "check_out": removalDate.toString(),
      "tags": tagsWith.join("|-|"),
      "extras": extras.toString(),
      "requirements": "{}",
      "description": description.toString(),
      "bookingNote": "a",
      "bookingOffset": "a",
      "bookingWindow": "a",
      "BookingImportURL": "a",
      "minimumBookingDuration": "a",
    });
    log(response.body);
    final decodedJson = jsonDecode(response.body) as Map<String, dynamic>;
    if (decodedJson["SCC"] == true) {
      log(response.body);
      return response;
    } else {
      log(response.body);
      throw Exception(decodedJson["err"]);
    }
  }
}
