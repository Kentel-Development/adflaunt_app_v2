// ignore_for_file: strict_raw_type

import 'dart:convert';

import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;

class LivePreviewService {
  static Future<List<String>> getLivePreview(String bookingID) async {
    final response = await http
        .get(Uri.parse(StringConstants.baseUrl + "/api/unzipper/$bookingID"));
    if (response.statusCode == 200) {
      print(response.body);
      Map json = jsonDecode(response.body) as Map;
      List<dynamic> content = json["content"] as List<dynamic>;
      List<String> images = [];
      content.forEach((element) {
        if (element.toString().contains(".png") ||
            element.toString().contains(".jpg") ||
            element.toString().contains(".jpeg") ||
            element.toString().contains(".webp")) {
          images.add(element.toString());
        }
      });
      return images;
    } else {
      throw Exception('Failed to load live preview');
    }
  }
}
