import 'dart:convert';

import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/product/models/profile/profile_model.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static Future<ProfileModel> getUser(String id) async {
    var url = Uri.parse('${StringConstants.baseUrl}/api/getprofile/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;
      return ProfileModel.fromJson(json);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
