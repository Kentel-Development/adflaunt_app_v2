import 'dart:convert';
import 'dart:developer';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/user_check_model.dart';

class Register {
  static Future<String> verifyEmail(String email) async {
    log(email);
    final response = await http
        .post(Uri.parse("${StringConstants.baseUrl}/api/verify/email"), body: {
      "email": email,
    });
    log(response.body);
    Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200 && data["SCC"] == true) {
      return data["verificationCode"].toString();
    } else {
      throw Exception('Failed to verify');
    }
  }

  static Future<http.Response> register(String email, String password,
      String name, String phoneNumber, DateTime? date, String method) async {
    var url = Uri.parse('${StringConstants.baseUrl}/api/register');
    var ipResponse = await http.get(Uri.parse('http://ip-api.com/json'));
    if (ipResponse.statusCode == 200) {
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
        'fullName': name,
        "IPDATA": ipResponse.body,
        "phoneNumber": phoneNumber,
        "dateOfBirth": date == null
            ? ""
            : DateFormat(StringConstants.dateFormat).format(date),
        "thirdParty": method
      });
      log(response.body);
      return response;
    } else {
      throw Exception('Failed to register');
    }
  }

  static Future<http.Response> google(
      String id, String email, String? photoUrl, String fullName) async {
    var url = Uri.parse('${StringConstants.baseUrl}/api/google_auth');

    var response = await http.post(url, body: {
      'email': email,
      'id': id,
      if (photoUrl != null) 'photoUrl': photoUrl,
      "displayName": fullName,
    });
    log(response.body);
    return response;
  }

  static Future<http.Response> apple(
      String firstName, String lastName, String? email, String id) async {
    var url = Uri.parse('${StringConstants.baseUrl}/api/apple_auth');
    var httpbinResponse = await http.get(Uri.parse('http://httpbin.org/json'));
    log(httpbinResponse.body);
    var response = await http.post(url, body: {
      'email': email,
      'id': id,
      "firstName": firstName,
      "lastName": lastName,
    });
    log(response.body);
    return response;
  }

  static Future<http.Response> appleLogin(String id) async {
    var url = Uri.parse('${StringConstants.baseUrl}/api/apple_auth?id=$id');
    var response = await http.get(
      url,
    );
    log(response.body);
    return response;
  }

  static Future<UserCheckModel> userCheck(String? email, String? phone) async {
    var url = Uri.parse('${StringConstants.baseUrl}/api/userCheck');
    var response = await http.post(url, body: {
      if (email != null) 'email': email,
      if (phone != null) 'phoneNumber': phone,
    });
    log(response.body);
    return userCheckModelFromJson(response.body);
  }
}
