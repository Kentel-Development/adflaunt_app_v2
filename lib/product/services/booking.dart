import 'dart:convert';
import 'dart:developer';

import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/product/models/bookings_with_profile_images.dart';
import 'package:adflaunt/product/models/orders/orders_model.dart';
import 'package:adflaunt/product/models/unavailable_dates_model.dart';
import 'package:adflaunt/product/services/upload.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/adapters/profile/profile_adapter.dart';

class BookingService {
  static Future<OrdersModel> getOrders() async {
    final currentUser = Hive.box<ProfileAdapter>("user").get("userData")!;
    final response = await http
        .post(Uri.parse("${StringConstants.baseUrl}/api/orders"), body: {
      "email": currentUser.email,
      "password": currentUser.password,
    });
    if (response.statusCode == 200) {
      log(response.body);
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return OrdersModel.fromJson(json);
    } else {
      log(response.body);
      throw Exception('Failed to load data');
    }
  }

  static Future<BookingsWithProfileImages> getBookingsWithProfileImages(
      String id) async {
    final response = await http.get(Uri.parse(
        StringConstants.baseUrl + '/api/booking/calendarProfiler/$id'));
    if (response.statusCode == 200) {
      final model = jsonDecode(response.body) as Map<String, dynamic>;
      final bookings = BookingsWithProfileImages.fromJson(model);
      log(response.body);
      return bookings;
    } else {
      throw Exception('Failed to load data');
    }
  }

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

  static Future<As> getBookingDetails(String id) async {
    final response = await http.get(
      Uri.parse("${StringConstants.baseUrl}/api/order/$id"),
    );
    if (response.statusCode == 200) {
      log(response.body);
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final booking = As.fromJson(json);
      return booking;
    } else {
      log("asdasdas${response.body}");
      throw Exception('Failed to load data');
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

  static Future<http.Response> approveBooking(String id) async {
    final currentUser = Hive.box<ProfileAdapter>("user").get("userData")!;
    final response = await http
        .post(Uri.parse("${StringConstants.baseUrl}/api/approve/$id"), body: {
      "email": currentUser.email,
      "password": currentUser.password,
    });
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to approve booking');
    }
  }

  static Future<http.Response> rejectBooking(String id) async {
    final currentUser = Hive.box<ProfileAdapter>("user").get("userData")!;
    final response = await http
        .post(Uri.parse("${StringConstants.baseUrl}/api/decline/$id"), body: {
      "email": currentUser.email,
      "password": currentUser.password,
    });
    if (response.statusCode == 200) {
      return response;
    } else {
      log(id.toString());
      log(response.body);
      throw Exception('Failed to reject booking');
    }
  }

  static Future<http.Response> uploadProof(
      String listingID, String id, List<XFile> filePath) async {
    final currentUser = Hive.box<ProfileAdapter>("user").get("userData")!;
    List<String> fileNames = [];
    for (var i = 0; i < filePath.length; i++) {
      final file = await UploadService.uploadImage(filePath[i].path);
      fileNames.add(file);
    }

    final response = await http.post(
        Uri.parse(
            "${StringConstants.baseUrl}/api/booking/addProof/$listingID/$id"),
        body: {
          "email": currentUser.email,
          "password": currentUser.password,
          "images": fileNames.join("|-|")
        });
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to upload proof please try again later');
    }
  }

  static Future<http.Response> addReview(
      String listingID, String id, String review, String rating) async {
    final currentUser = Hive.box<ProfileAdapter>("user").get("userData")!;
    final response = await http.post(
        Uri.parse("${StringConstants.baseUrl}/api/reviews/add/$listingID/$id"),
        body: {
          "email": currentUser.email,
          "password": currentUser.password,
          "review": rating,
          "stars": review
        });
    if (response.statusCode == 200) {
      log(response.body);
      return response;
    } else {
      throw Exception('Failed to add review please try again later');
    }
  }
}
