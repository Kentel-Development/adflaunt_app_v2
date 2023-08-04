import 'dart:developer';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class LoginAPI {
  static Future<http.Response> login(
    String email,
    String password,
    String? lat,
    String? long,
  ) async {
    final url = Uri.parse('${StringConstants.baseUrl}/api/login');
    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
          if (lat != null) 'lat': lat,
          if (long != null) 'long': long,
        },
      );
      log(response.body);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> saveAccountCredentials(
    ProfileAdapter profileModel,
  ) async {
    await Hive.box<ProfileAdapter>('user').put('userData', profileModel);

    /// TODO(): Uncomment this when push notification is implemented
    /*if (profileModel.id != null) {
      FirebaseMessaging.instance.subscribeToTopic(profileModel.id!);
    }*/
  }

  static Future<void> logout() async {
    /// TODO(): Uncomment this when push notification is implemented
    /// final profileModel = Hive.box<ProfileAdapter>('user').get('userData');
    /// FirebaseMessaging.instance.unsubscribeFromTopic(profileModel.id!);
    await Hive.box<ProfileAdapter>('user').delete('userData');
  }
}
