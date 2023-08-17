import 'dart:convert';
import 'dart:developer';

import 'package:adflaunt/product/models/predictions.dart';
import 'package:http/http.dart' as http;

class PlaceAutocompleteService {
  static Future<dynamic> placeToCoordinates(String placeId) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyCyVkkjdssN7EpjmctOv42FwG5i8ZsPXiI";

    try {
      http.Response response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        if (json.containsKey("error_message")) {
          throw Exception(json["error_message"]);
        } else {
          log(json["result"]["geometry"]["location"].toString());
          return json["result"]["geometry"]["location"];
        }
      } else {
        throw Exception("Unexpected Error");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Predictions> autocomplete(String text) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$text&key=AIzaSyCyVkkjdssN7EpjmctOv42FwG5i8ZsPXiI";

    try {
      http.Response response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        if (json.containsKey("error_message")) {
          throw Exception(json["error_message"]);
        } else {
          log(response.body);
          return Predictions.fromJson(json);
        }
      } else {
        throw Exception("Unexpected Error");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
