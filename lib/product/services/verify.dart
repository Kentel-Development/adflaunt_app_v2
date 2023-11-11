import 'dart:convert';

import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;

class VerifyService {
  static Future<String> createSession() async {
    var uname = StringConstants.twilio_account_sid;
    var pword = StringConstants.twilio_auth_token;
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': authn,
    };

    var data = {"FriendlyName": "verify"};
    var url = Uri.parse('https://verify.twilio.com/v2/Services');
    var res = await http.post(url, headers: headers, body: data);
    if (res.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(res.body) as Map<String, dynamic>;
      return data["sid"].toString();
    } else {
      print(res.body);
      throw Exception("Exception");
    }
  }

  static Future<bool> sendOtp(String phone, String sid) async {
    var uname = StringConstants.twilio_account_sid;
    var pword = StringConstants.twilio_auth_token;
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': authn,
    };

    var data = {'To': phone, "Channel": "sms"};
    var url =
        Uri.parse('https://verify.twilio.com/v2/Services/$sid/Verifications');
    var res = await http.post(url, headers: headers, body: data);
    if (res.statusCode == 201) {
      return true;
    } else {
      print(res.body);
      return false;
    }
  }

  static Future<bool> verifyOtp(String sid, String code, String phone) async {
    var uname = StringConstants.twilio_account_sid;
    var pword = StringConstants.twilio_auth_token;
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': authn,
    };

    var data = {
      'To': phone,
      'Code': code,
    };

    var url = Uri.parse(
        'https://verify.twilio.com/v2/Services/$sid/VerificationCheck');
    var res = await http.post(url, headers: headers, body: data);
    if (res.statusCode == 200) {
      return true;
    } else {
      print(res.statusCode.toString());
      print(res.body);
      throw Exception("Unexpected problem, please try again.");
    }
  }
}
