import 'dart:developer';
import 'dart:io';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/product/services/upload.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;

class VerificationAPI {
  static Future<bool> verifyID(File front, File back, String address) async {
    final currentUser = Hive.box<ProfileAdapter>("user").get("userData");
    try {
      final url = Uri.parse("${StringConstants.baseUrl}/api/verify/ID");
      String frontData = (await UploadService.uploadImage(front.path));
      String backData = (await UploadService.uploadImage(back.path));
      final response = await http.post(
        url,
        body: {
          "photoOfId": frontData,
          "backPhoto": backData,
          "deliveryAddress": address,
          "email": currentUser!.email,
          "password": currentUser.password,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      log(e.toString());
      throw Exception("Error verifying ID +  $e");
    }
  }
}
