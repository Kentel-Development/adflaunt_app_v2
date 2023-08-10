import 'dart:convert';
import 'dart:developer';

import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/product/models/unavailable_dates_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../core/adapters/profile/profile_adapter.dart';

class BookingService {
  static Future<UnavailableDatesModel> getBookedDates(String id) async {
    final response = await http
        .get(Uri.parse(StringConstants.baseUrl + '/api/booking/calendar/$id'));
    if (response.statusCode == 200) {
      final model = UnavailableDatesModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      log(response.body);
      return model;
    } else {
      throw Exception('Failed to load booked dates');
    }
  }

  static Future<http.Response> makeBooking(
      DateTime from,
      DateTime to,
      String title,
      String id,
      String description,
      String? file,
      String paymentID) async {
    ProfileAdapter currentUser =
        Hive.box<ProfileAdapter>("user").get("userData")!;
    final response = await http
        .post(Uri.parse("${StringConstants.baseUrl}/api/book"), body: {
      "paymentID": paymentID,
      "listingID": id,
      "from": DateFormat('yyyy-MM-dd').format(from),
      "to": DateFormat('yyyy-MM-dd').format(to),
      "title": title,
      "description": description,
      "email": currentUser.email,
      "password": currentUser.password,
      if (file != null) "printingFile": file
    });
    if (response.statusCode == 200) {
      log(response.body);
      return response;
    } else {
      log(response.body);
      throw Exception('Failed to load data');
    }
  }
}
