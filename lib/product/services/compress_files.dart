import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';

class ArchiveService {
  static Future<String> compressFiles(List<String> files) async {
    final dir = await getTemporaryDirectory();
    final Archive archive = Archive();
    for (final file in files) {
      final fileData = File(file).readAsBytesSync();
      final fileName = file.split('/').last;
      final data = ArchiveFile(fileName, fileData.length, fileData);
      archive.addFile(data);
    }
    final zipEncoder = ZipEncoder();

    final encodedData = zipEncoder.encode(archive);
    final zipFile = File('${dir.path}/archive.zip');
    await zipFile.writeAsBytes(encodedData!);
    return zipFile.path;
  }
}
