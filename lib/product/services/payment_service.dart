import 'dart:developer';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  ProfileAdapter currentUser =
      Hive.box<ProfileAdapter>("user").get("userData")!;
  Future<String> createPaymentIntent(
      String listingID, DateTime from, DateTime to, String? paymentID) async {
    try {
      log(listingID);

      //Request body
      Map<String, dynamic> body = {
        "email": currentUser.email,
        "password": currentUser.password,
        "from": DateFormat(StringConstants.dateFormatBackend).format(from),
        "to": DateFormat(StringConstants.dateFormatBackend).format(to),
        if (paymentID != null) "paymentMethod": paymentID
      };
      var response = await http.post(
        Uri.parse(
            '${StringConstants.baseUrl}/api/stripe/createPayment/$listingID'),
        body: body,
      );
      log(response.statusCode.toString());
      log(response.body);
      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<String> createSetupIntent() async {
    try {
      //Request body
      Map<String, dynamic> body = {
        "email": currentUser.email,
        "password": currentUser.password,
      };
      return (await http.post(
        Uri.parse('${StringConstants.baseUrl}/api/stripe/setupIntent'),
        body: body,
      ))
          .body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<String> attach(String paymentMethod) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        "email": currentUser.email,
        "password": currentUser.password,
        "paymentMethod": paymentMethod
      };
      return (await http.post(
        Uri.parse('${StringConstants.baseUrl}/api/stripe/attach'),
        body: body,
      ))
          .body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<String> detach(String paymentMethod) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        "email": currentUser.email,
        "password": currentUser.password,
        "paymentMethod": paymentMethod
      };
      return (await http.post(
        Uri.parse('${StringConstants.baseUrl}/api/stripe/detach'),
        body: body,
      ))
          .body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<String> listPaymentMethods() async {
    try {
      //Request body
      Map<String, dynamic> body = {
        "email": currentUser.email,
        "password": currentUser.password,
      };

      return (await http.post(
        Uri.parse('${StringConstants.baseUrl}/api/stripe/list_methods'),
        body: body,
      ))
          .body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
