import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;

class UploadService {
  static Future<String> uploadImage(String filePath) async {
    File file = File(filePath);
    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse("${StringConstants.baseUrl}/api/upload"));
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
        log(data.body);
        final dataJson = jsonDecode(data.body);
        return dataJson["file"].toString();
      } else {
        log(response.statusCode.toString());
        throw Exception("Error uploading image");
      }
    } catch (e) {
      log(e.toString());
      throw Exception("Error uploading image + $e");
    }
  }
}
