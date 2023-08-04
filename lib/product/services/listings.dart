import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/product/models/listings/results.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ListingsAPI {
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
      String? km) async {
    try {
      var url =
          Uri.parse('${StringConstants.baseUrl}/api/get/listingsFilterer');
      url = Uri.http(url.authority, url.path, {
        if (type != null) 'type': type.toString(),
        if (category != null) 'category': category,
        //if (from != null) 'from': from,
        //if (to != null) 'to': to,
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
      String location,
      int type_,
      int revisions,
      bool digital,
      String printsqfeet,
      String printsqfootage,
      int category,
      String population,
      String discountAvailable,
      String installationDate,
      String removalDate,
      String tags,
      List<File> file,
      dynamic extras,
      String requirements,
      String description,
      String bookingNote,
      String bookingOffset,
      String bookingWindow,
      String maxBookingDuration,
      String minBookingDuration,
      ProfileAdapter currentUser) async {
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
        Map<String, dynamic> map =
            jsonDecode(data.body) as Map<String, dynamic>;
        log(data.body);
        if (i == file.length - 1) {
          files = files + map["file"].toString();
        } else {
          files = "${files + map["file"].toString()}|-|";
        }
      }
    }
    var url = Uri.parse('${StringConstants.baseUrl}/api/create/listing');
    final location = await placemarkFromCoordinates(
        double.parse(lat), double.parse(long),
        localeIdentifier: "en_US");
    final response = await http.post(url, body: {
      "email": currentUser.email,
      "password": currentUser.password,
      "title": title.toString(),
      "lat": lat.toString(),
      "long": long.toString(),
      "city": location.first.locality.toString(),
      "state": location.first.administrativeArea.toString(),
      "country": location.first.country.toString(),
      "images": files.toString(),
      "price": price.toString(),
      "location": location.first.name.toString(),
      "type": type_.toString(),
      "revision_limit": revisions.toString(),
      "digital": digital.toString(),
      "length": printsqfeet.toString(),
      "width": printsqfootage.toString(),
      "typeOfAd": category.toString(),
      "population": population.toString(),
      "discountAvailable": "1",
      "check_in": installationDate.toString(),
      "check_out": removalDate.toString(),
      "tags": tags.toString(),
      "extras": extras,
      "requirements": "{}",
      "description": description.toString(),
      "bookingNote": "a",
      "bookingOffset": "a",
      "bookingWindow": "a",
      "BookingImportURL": "a",
      "minimumBookingDuration": "a",
    });
    if (true) {
      log(response.body);
      return response;
    }
  }
}
