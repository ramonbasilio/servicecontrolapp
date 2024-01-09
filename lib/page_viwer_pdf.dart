import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:servicecontrolapp/controller/Firebase/firebase_service.dart';
import 'package:servicecontrolapp/helper/http_helper.dart';
import 'package:share_plus/share_plus.dart';

class ViwerPdf extends StatefulWidget {
  final String path;
  const ViwerPdf({required this.path, super.key});

  @override
  State<ViwerPdf> createState() => _ViwerPdfState();
}

class _ViwerPdfState extends State<ViwerPdf> {
  Future<String> localPath() async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  Future<File> localFile() async {
    final path = await localPath();
    return File('$path/exemplo.pdf');
  }

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () async {
                File file = await localFile();
                Uint8List pdfbytes = await file.readAsBytes();
                String base64pdf = base64Encode(pdfbytes);
                await Http().callCloudFunc(base64pdf);
                if (kDebugMode) {
                  print('pdf base64: $base64pdf');
                }
                await FirebaseService().savePdfFirestore(pdfbytes);
                Share.shareXFiles([XFile(file.path)]);
              },
              child: const Text('Share'))
        ],
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: false,
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              print(error.toString());
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
          ),
        ],
      ),
    );
  }
}
