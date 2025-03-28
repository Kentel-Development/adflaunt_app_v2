import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../core/constants/string_constants.dart';

class NotificationService {
  static Future<dynamic> sendChatNotification(
    String externalUserId,
    String message,
    String name,
    String chatID,
  ) async {
    log("Sending notification to $externalUserId");
    log("Sending notification to $message");
    log("Sending notification to $name");
    log("Sending notification to $chatID");
    try {
      final unseenUrl = Uri.parse(
          StringConstants.baseUrl + "/api/seeNumMessages/$externalUserId");
      int? unseenNum;
      try {
        final res = await http.get(unseenUrl);
        log("Response ${res.body}");
        unseenNum =
            ((jsonDecode(res.body) as Map<String, dynamic>)["num"] as int?);
        log("Unseen $unseenNum");
      } catch (e) {
        log("Error $e");
      }
      final body = {
        "to": "/topics/$externalUserId",
        "notification": {
          "title": name,
          "body": message,
          if (unseenNum != null) "badge": unseenNum,
          "sound": "default",
        },
        "data": {
          "page": "chat",
          "id": externalUserId,
          "chatID": chatID,
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "name": name,
          "content_available": true,
        }
      };
      final url = Uri.parse("https://fcm.googleapis.com/fcm/send");
      final msg = jsonEncode(body);

      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=${StringConstants.firebaseNotificationKey}',
          },
          body: msg);

      if (response.statusCode == 200) {
        log("Response ${response.body}");
      } else {
        log("Response ${response.body}");
      }
    } catch (e) {
      log("Error $e");
    }
  }
}
