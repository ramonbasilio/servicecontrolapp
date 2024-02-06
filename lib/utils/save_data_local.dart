import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class DataLocal {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String pdfName) async {
    final path = await _localPath;
    return File('$path/$pdfName');
  }

  // Future<File> createPathFile(String nameFile) async {
  //   final path = await _localPath;
  //   return File('$path/$nameFile');
  // }

  // Future<String> getFilePath(String nameFile) async {
  //   final directory = await _localPath;
  //   String filePath = '$directory/$nameFile';
  //   return filePath;
  // }

  Future<void> savePdf(Uint8List pdf, String pdfName) async {
    final file = await _localFile(pdfName);
    await file.writeAsBytes(pdf);
  }

  Future<Uint8List> readPdf(String pdfName) async {
    try {
      final file = await _localFile(pdfName);
      final conteudo = await file.readAsBytes();
      print('Conteudo lido: $conteudo');
      return conteudo;
    } catch (e) {
      throw 'Houve um erro ao ler pdf: $e';
    }
  }

  Future<File> createPathFile(String fileName) async {
    String path = await _localPath;
    return File('$path/$fileName');
  }
}
