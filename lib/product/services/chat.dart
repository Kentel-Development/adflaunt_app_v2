import 'dart:convert';
import 'dart:developer';

import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:adflaunt/product/models/chat/chat.dart';
import 'package:adflaunt/product/models/chat/inbox.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ChatServices {
  static Future<Inbox> getInbox() async {
    final currentUser = Hive.box<ProfileAdapter>('user').get('userData')!;
    final response = await http.post(
        Uri.parse(StringConstants.baseUrl + "/api/get/inbox"),
        body: {"email": currentUser.email, "password": currentUser.password});
    log(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['SCC'] == true) {
        return Inbox.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception(jsonDecode(response.body)['err']);
      }
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  static Future<List<Message>> pagination(String chatId, int page) async {
    final currentUser = Hive.box<ProfileAdapter>('user').get('userData')!;
    final response = await http.post(
        Uri.parse(StringConstants.baseUrl + "/api/get/chat/$chatId/$page"),
        body: {
          "email": currentUser.email,
          "password": currentUser.password,
        });
    log(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['SCC'] == true) {
        List<Message> messages = [];
        // ignore: inference_failure_on_untyped_parameter
        jsonDecode(response.body)['messages'].forEach((element) {
          messages.add(Message.fromJson(element as Map<String, dynamic>));
        });
        return messages;
      } else {
        throw Exception(jsonDecode(response.body)['err']);
      }
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  static Future<String> createChat(String uid, String id) async {
    final user = Hive.box<ProfileAdapter>('user').get('userData')!;
    var url = Uri.parse('${StringConstants.baseUrl}/api/create/chat');
    var response = await http.post(url, body: {
      "reciever": uid,
      "email": user.email,
      "password": user.password,
      "listingID": id,
    });
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body)['_id'].toString();
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }
}
