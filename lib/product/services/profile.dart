import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProfileService {
  static Future<String> deleteOldImage() async {
    final currentUser = Hive.box<ProfileAdapter>('user').get('userData')!;
    final url = Uri.parse('${StringConstants.baseUrl}/api/deleteProfileImage');
    final response = await http.post(url, body: {
      'email': currentUser.email!,
      'password': currentUser.password!,
      'uid': currentUser.id!,
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete image');
    }
  }

  static Future<http.Response> editProfile(String email, String password,
      String name, File? file, DateTime? date) async {
    final currentUser = Hive.box<ProfileAdapter>("user").get("userData");
    var url = Uri.parse('${StringConstants.baseUrl}/api/updateprofile');
    if (file != null) {
      var request = http.MultipartRequest(
          'POST', Uri.parse("${StringConstants.baseUrl}/api/upload"));
      /*request.fields.addAll({
        "email": email,
        "password": password,
        "fullName": name,
        "phoneNumber": Hive.box("user").get("phoneNumber"),
      });*/
      request.files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          await file.length(),
          filename: file.path.split('/').last,
        ),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        final data = await http.Response.fromStream(response);
        var url = Uri.parse('${StringConstants.baseUrl}/api/updateprofile');
        var responseOfEdit = await http.post(url, body: {
          'email': email,
          'password': password,
          'fullName': name,
          'phoneNumber': currentUser!.phoneNumber!,
          'profileImage': jsonDecode(data.body)["file"],
        });
        return responseOfEdit;
      } else {
        throw Exception('Failed to edit listing');
      }
    } else {
      Map<String, dynamic> body = {
        'email': email,
        'password': password,
        'fullName': name,
      };
      if (date != null) {
        body["dateOfBirth"] =
            DateFormat(StringConstants.dateFormat).format(date).toString();
      }
      var responseOf = await http.post(url, body: body);

      log(responseOf.body);
      return responseOf;
    }
  }

  static Future<http.Response> updateCredentials(
      String email,
      String password,
      String? phoneNumber,
      String? newEmail,
      String? newPassword,
      String? newPhoneNumber) async {
    var url =
        Uri.parse('${StringConstants.baseUrl}api/update_login_credentials');
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    if (newEmail != null) {
      body['new_email'] = newEmail;
    }
    if (newPassword != null) {
      body['new_password'] = newPassword;
    }
    if (newPhoneNumber != null) {
      body['new_phoneNumber'] = newPhoneNumber;
    }
    var response = await http.post(url, body: body);
    log(response.body);
    return response;
  }
}
