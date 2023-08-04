import 'dart:developer';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class BalanceAPI {
  static Future<String> getBalance() async {
    ProfileAdapter currentUser =
        Hive.box<ProfileAdapter>("user").get("userData")!;
    final response = await http
        .post(Uri.parse("${StringConstants.baseUrl}/api/getBalance"), body: {
      "email": currentUser.email,
      "password": currentUser.password,
    });
    if (response.statusCode == 200) {
      log(response.body);
      return response.body;
    } else {
      log(response.body);
      return response.body;
    }
  }
}
