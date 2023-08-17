import 'dart:io';
import 'package:adflaunt/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DownloadService {
  static Future<File> downloadFile(String name) async {
    final response =
        await http.get(Uri.parse(StringConstants.baseStorageUrl + name));
    final bytes = response.bodyBytes;
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/$name';
    final file = File(imagePath);
    await file.writeAsBytes(bytes);
    return file;
  }
}
