import 'dart:convert';
import 'dart:developer';

import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  static Future<Map<String, dynamic>> categorizeReviews(String id) async {
    var url =
        Uri.parse('${StringConstants.baseUrl}/api/categorize/reviews/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log(response.body);
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return json;
    } else {
      log('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load listings');
    }
  }

  static Future<Map<String, dynamic>> getReviews(String id, int page) async {
    var url = Uri.parse(
        '${StringConstants.baseUrl}/api/reviewSpecific/$id?page=$page');
    print('${StringConstants.baseUrl}/api/reviewSpecific/$id?page=$page');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log(response.body);
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return json;
    } else {
      log('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load listings');
    }
  }

  static Future<Map<String, dynamic>> getUserReviews(
      String id, int page) async {
    var url = Uri.parse(
        '${StringConstants.baseUrl}/api/reviewSpecificUser/$id?page=$page');
    print('${StringConstants.baseUrl}/api/reviewSpecificUser/$id?page=$page');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log(response.body);
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return json;
    } else {
      log('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load listings');
    }
  }
}
