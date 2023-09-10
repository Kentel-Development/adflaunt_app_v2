import 'dart:convert';
import 'dart:developer';

import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/product/models/profile/profile_model.dart';
import 'package:adflaunt/product/models/user_profile_model.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static Future<ProfileModel> getUser(String id) async {
    var url = Uri.parse('${StringConstants.baseUrl}/api/getprofile/$id');
    final response = await http.get(url);
    log(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;

      return ProfileModel.fromJson(json);
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<UserProfileModel> getUserProfile(String id) async {
    var url = Uri.parse('${StringConstants.baseUrl}/api/detailedProfile/$id');
    final response = await http.get(url);
    log("prefix" + response.body);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> json =
            jsonDecode(response.body) as Map<String, dynamic>;
        UserProfileModel userProfileModel = UserProfileModel.fromJson(json);
        return userProfileModel;
      } catch (e) {
        throw Exception('Failed to load user');
      }
    } else {
      throw Exception('Failed to load user');
    }
  }
}
