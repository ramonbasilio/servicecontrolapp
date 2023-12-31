// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class ViwerPdf extends StatefulWidget {
//   String path;
//   ViwerPdf({required this.path, super.key});

//   @override
//   State<ViwerPdf> createState() => _ViwerPdfState();
// }

// class _ViwerPdfState extends State<ViwerPdf> {
//   final Completer<PDFViewController> _controller =
//       Completer<PDFViewController>();
//   int? pages = 0;
//   int? currentPage = 0;
//   bool isReady = false;
//   String errorMessage = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Stack(
//         children: [
//           PDFView(
//             filePath: widget.path,
//             enableSwipe: true,
//             swipeHorizontal: true,
//             autoSpacing: false,
//             pageFling: false,
//             onRender: (_pages) {
//               setState(() {
//                 pages = _pages;
//                 isReady = true;
//               });
//             },
//             onError: (error) {
//               print(error.toString());
//             },
//             onPageError: (page, error) {
//               print('$page: ${error.toString()}');
//             },
//             onViewCreated: (PDFViewController pdfViewController) {
//               _controller.complete(pdfViewController);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
