import 'dart:convert';
import 'dart:developer';

import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../core/adapters/profile/profile_adapter.dart';

class PostService {
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
