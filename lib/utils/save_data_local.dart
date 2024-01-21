import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class DataLocal {
  Future<File> createPathFile(String nameFile) async {
    final directory = await getApplicationSupportDirectory();
    final path = directory.path;
    return File('$path/$nameFile');
  }

  Future<String> getFilePath(String nameFile) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$nameFile';
    return filePath;
  }

  Future<File> saveFile(Uint8List data, String nameFile) async {
    final file = await createPathFile(nameFile);
    return file.writeAsBytes(data);
  }
}
