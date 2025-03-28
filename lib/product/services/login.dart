import 'dart:convert';
import 'dart:developer';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
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
    if (profileModel.id != null) {
      await Hive.box<ProfileAdapter>('user').put('userData', profileModel);
    } else {
      log('User ID is null, please try again.');
      throw Exception('User ID is null, please try again.');
    }

    if (profileModel.id != null) {
      FirebaseMessaging.instance.subscribeToTopic(profileModel.id!);
      final unseenUrl = Uri.parse(
          StringConstants.baseUrl + "/api/seeNumMessages/${profileModel.id}");
      http.get(unseenUrl).then((res) {
        if (res.statusCode == 200) {
          log("Response ${res.body}");
          FlutterAppBadger.updateBadgeCount(
              (jsonDecode(res.body) as Map<String, dynamic>)["num"] as int);
        }
      });
    } else {
      log('User ID is null, please try again.');
      throw Exception('User ID is null, please try again.');
    }
  }

  static Future<void> logout() async {
    final profileModel = Hive.box<ProfileAdapter>('user').get('userData')!;
    FirebaseMessaging.instance.unsubscribeFromTopic(profileModel.id!);
    await Hive.box<ProfileAdapter>('user').delete('userData');
    await Hive.box<ProfileAdapter>('favorites').clear();
    await Hive.box<ProfileAdapter>('recentSearch').clear();
    await Hive.box<ProfileAdapter>('location').clear();
    FlutterAppBadger.removeBadge();
  }
}
