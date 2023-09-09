import 'dart:developer';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
          'email': "ricky@digitalmarketspace.net",
          'password':
              "e6fd9d2582efcedc8cbbc0db1424e39f9c7bf8209c8f27c9ef022ba425116acd676ce6aae5e767fd5d77dc7f0762f44ce80f77e0ffda159fdf5e4c8e035362a3",
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
    if (profileModel.id != null) {
      await Hive.box<ProfileAdapter>('user').put('userData', profileModel);
    } else {
      log('User ID is null, please try again.');
      throw Exception('User ID is null, please try again.');
    }

    if (profileModel.id != null) {
      FirebaseMessaging.instance.subscribeToTopic(profileModel.id!);
    } else {
      log('User ID is null, please try again.');
      throw Exception('User ID is null, please try again.');
    }
  }

  static Future<void> logout() async {
    final profileModel = Hive.box<ProfileAdapter>('user').get('userData')!;
    FirebaseMessaging.instance.unsubscribeFromTopic(profileModel.id!);
    await Hive.box<ProfileAdapter>('user').delete('userData');
  }
}
